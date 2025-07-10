// ==UserScript==
// @name         Fix WhatsApp Web Notifications
// @description  Automatically clicks the notification button
// @version      1.0
// @namespace    https://web.whatsapp.com/
// @match        https://web.whatsapp.com/*
// @run-at       document-idle
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    var waitForButton = setInterval(function() {
        // Look for the "Turn on" button with various possible selectors
        let button = document.querySelector('div[role="button"][aria-label*="Turn on"]') ||
                     document.querySelector('div[role="button"]:has-text("Turn on")') ||
                     document.querySelector('span:has-text("Turn on desktop notifications")') ||
                     document.evaluate("//span[contains(text(),'Turn on')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        
        if(button) {
            // Find the clickable parent if needed
            while(button && !button.onclick && button.parentElement) {
                if(button.parentElement.getAttribute('role') === 'button' || 
                   button.parentElement.onclick) {
                    button = button.parentElement;
                    break;
                }
                button = button.parentElement;
            }
            
            if(button) {
                button.click();
                console.log('WhatsApp notification button clicked');
                clearInterval(waitForButton);
            }
        }
    }, 500);
    
    // Stop trying after 30 seconds
    setTimeout(function() {
        clearInterval(waitForButton);
    }, 30000);
})();