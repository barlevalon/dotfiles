// ==UserScript==
// @name         Fix Slack Notifications
// @description  Automatically clicks notification buttons and dismisses banners
// @version      1.1
// @namespace    https://app.slack.com/
// @match        https://*.slack.com/*
// @match        https://app.slack.com/*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    
    console.log('Slack notification fix script loaded');
    
    var clickedButtons = new Set();
    var attempts = 0;
    
    var waitForButton = setInterval(function() {
        attempts++;
        
        // Try multiple selectors for Slack's notification buttons and banners
        let buttons = [];
        
        // First priority: X close buttons (avoid clicking links)
        buttons.push(...Array.from(document.querySelectorAll('button')).filter(el => {
            const text = el.textContent.trim();
            return text === 'X' || text === '×' || text === '✕' || text === 'x';
        }));
        
        // Close buttons with aria-label
        buttons.push(
            document.querySelector('button[aria-label="Close"]'),
            document.querySelector('button[aria-label="Dismiss"]'),
            document.querySelector('button[aria-label*="close"]'),
            document.querySelector('button[aria-label*="dismiss"]')
        );
        
        // Banner dismiss buttons  
        buttons.push(
            document.querySelector('button[data-qa="banner_dismiss"]'),
            document.querySelector('button[data-qa="banner_close"]'),
            document.querySelector('[data-qa="banner"] button[type="button"]')
        );
        
        // Only then look for enable notifications
        buttons.push(...Array.from(document.querySelectorAll('button')).filter(el => 
            el.textContent.toLowerCase().includes('enable notifications') ||
            el.textContent.toLowerCase().includes('enable desktop notifications') ||
            el.textContent === 'Turn on'
        ));
        
        // Finally other dismiss buttons (but not links or link-style buttons)
        buttons.push(...Array.from(document.querySelectorAll('button:not(a)')).filter(el => {
            // Skip link-style buttons
            if (el.classList.contains('c-link--button') || 
                el.textContent.toLowerCase().includes('preferences') ||
                el.textContent.toLowerCase().includes('settings')) {
                return false;
            }
            return el.textContent.toLowerCase().includes('got it') ||
                   el.textContent.toLowerCase().includes('dismiss') ||
                   el.textContent.toLowerCase().includes('close') ||
                   el.textContent === 'OK';
        }));
        
        // XPath for buttons
        buttons.push(
            document.evaluate("//button[contains(text(),'enable notifications')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue,
            document.evaluate("//button[contains(text(),'Enable notifications')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue
        );
        
        // Notification prompt elements
        buttons.push(
            document.querySelector('button[data-qa="notifications_prompt_enable"]'),
            document.querySelector('div[data-qa="notifications_prompt"] button')
        );
        
        // Filter out nulls and already clicked
        buttons = buttons.filter(b => b !== null && b !== undefined);
        
        // Find first button we haven't clicked yet
        let button = buttons.find(b => !clickedButtons.has(b));
        
        if(button) {
            console.log('Found Slack button:', button.textContent || button.getAttribute('aria-label'), 
                        'Tag:', button.tagName, 
                        'Parent:', button.parentElement?.tagName);
            
            // Skip if this is actually a link
            if (button.tagName === 'A' || button.closest('a')) {
                console.log('Skipping link element');
                clickedButtons.add(button);
            } else {
                // Mark as clicked
                clickedButtons.add(button);
                
                // Try to click
                try {
                    button.click();
                    console.log('Slack button clicked successfully');
                    // Don't clear interval - keep looking for more buttons
                } catch(e) {
                    console.log('Failed to click, trying direct event dispatch');
                    button.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
                }
            }
        } else if (attempts % 40 === 0) {
            console.log(`Still monitoring for Slack notification buttons... (attempt ${attempts})`);
        }
    }, 500);
    
    // Stop trying after 60 seconds
    setTimeout(function() {
        clearInterval(waitForButton);
        console.log('Slack notification fix: Stopped looking for buttons after 60 seconds');
    }, 60000);
})();