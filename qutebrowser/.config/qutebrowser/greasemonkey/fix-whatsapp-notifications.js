// ==UserScript==
// @name         Fix WhatsApp Web Notifications
// @description  Automatically clicks the notification button
// @version      1.4
// @namespace    https://web.whatsapp.com/
// @match        https://web.whatsapp.com/*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    
    var attempts = 0;
    var foundNotification = false;
    var consecutiveEmptyAttempts = 0;
    var clickedButtons = new Set();
    
    var waitForButton = setInterval(function() {
        attempts++;
        
        // Try multiple selectors
        let buttons = [
            // Look for span containing "Turn on" text
            Array.from(document.querySelectorAll('span')).find(el => el.textContent === 'Turn on'),
            // Look for div with role=button containing Turn on
            Array.from(document.querySelectorAll('div[role="button"]')).find(el => el.textContent.includes('Turn on')),
            // XPath for any element with "Turn on" text
            document.evaluate("//span[text()='Turn on']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue,
            // Look for the notification banner
            document.querySelector('div[data-testid="notification-banner"]'),
            // Look for button in notification area
            document.querySelector('div[data-animate-modal-body="true"] div[role="button"]')
        ];
        
        let button = buttons.find(b => b !== null && b !== undefined && !clickedButtons.has(b));
        
        if(button) {
            // Mark as clicked immediately to prevent re-processing
            clickedButtons.add(button);
            foundNotification = true;
            consecutiveEmptyAttempts = 0;
            
            // Find the actual clickable element (might be parent)
            let clickTarget = button;
            while(clickTarget && clickTarget.getAttribute('role') !== 'button' && clickTarget.parentElement) {
                clickTarget = clickTarget.parentElement;
            }
            
            // Try to click immediately
            try {
                clickTarget.click();
                // Don't clear interval yet - let it check for more notifications
            } catch(e) {
                clickTarget.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
            }
        } else {
            consecutiveEmptyAttempts++;
            
            // If we found a notification before and now haven't seen any for 3 attempts (1.5 seconds), stop
            if (foundNotification && consecutiveEmptyAttempts >= 3) {
                clearInterval(waitForButton);
                return;
            }
        }
        
        // Stop after 15 seconds if we never found any notifications
        if (attempts >= 30 && !foundNotification) {
            clearInterval(waitForButton);
        }
    }, 500);
})();