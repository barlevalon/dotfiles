// ==UserScript==
// @name         Fix WhatsApp Web Notifications
// @description  Automatically clicks the notification button
// @version      1.1
// @namespace    https://web.whatsapp.com/
// @match        https://web.whatsapp.com/*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    
    console.log('WhatsApp notification fix script loaded');
    
    var attempts = 0;
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
        
        let button = buttons.find(b => b !== null && b !== undefined);
        
        if(button) {
            console.log('Found notification button:', button);
            
            // Find the actual clickable element (might be parent)
            let clickTarget = button;
            while(clickTarget && clickTarget.getAttribute('role') !== 'button' && clickTarget.parentElement) {
                clickTarget = clickTarget.parentElement;
            }
            
            // Try to click
            try {
                clickTarget.click();
                console.log('WhatsApp notification button clicked successfully');
                clearInterval(waitForButton);
            } catch(e) {
                console.log('Failed to click, trying direct event dispatch');
                clickTarget.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
                clearInterval(waitForButton);
            }
        } else if (attempts % 20 === 0) {
            console.log(`Still looking for notification button... (attempt ${attempts})`);
        }
    }, 500);
    
    // Stop trying after 60 seconds
    setTimeout(function() {
        clearInterval(waitForButton);
        console.log('WhatsApp notification fix: Stopped looking for button after 60 seconds');
    }, 60000);
})();