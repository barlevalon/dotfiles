// ==UserScript==
// @name         Fix Slack Notifications
// @description  Automatically clicks notification buttons and dismisses banners
// @version      1.3
// @namespace    https://app.slack.com/
// @match        https://*.slack.com/*
// @match        https://app.slack.com/*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    

    
    var clickedButtons = new Set();
    var attempts = 0;
    var foundInitialNotifications = false;
    var consecutiveEmptyAttempts = 0;
    
    var waitForButton = setInterval(function() {
        attempts++;
        
        // Try multiple selectors for Slack's notification buttons and banners
        let buttons = [];
        
        // Check if we have an "enable notifications" banner first
        const banners = document.querySelectorAll('[data-qa="banner"], [role="banner"]');
        let hasEnableNotificationsBanner = false;
        
        banners.forEach(banner => {
            const text = banner.textContent.toLowerCase();
            if (text.includes('slack needs your permission') || 
                text.includes('enable notifications') ||
                text.includes('turn on notifications')) {
                hasEnableNotificationsBanner = true;
            }
        });
        
        // If we have an enable notifications banner, prioritize those buttons
        if (hasEnableNotificationsBanner) {
            // Enable notifications buttons FIRST
            buttons.push(...Array.from(document.querySelectorAll('button.c-link--button')).filter(el => {
                const text = el.textContent.toLowerCase();
                return (text.includes('enable notifications') ||
                        text.includes('enable desktop notifications') ||
                        text === 'turn on') &&
                       !text.includes('preferences') &&
                       !text.includes('settings');
            }));
        }
        
        // THEN add close/dismiss buttons
        buttons.push(
            document.querySelector('button[data-qa="banner_close_btn"]'),  // Most specific selector
            document.querySelector('button[data-qa="banner_dismiss"]'),
            document.querySelector('button[data-qa="banner_close"]'),
            document.querySelector('.c-banner__close'),  // Class-based selector for close button
            document.querySelector('[data-qa="banner"] button[aria-label="Close"]'),
            document.querySelector('[data-qa="banner"] button[aria-label="Dismiss"]')
        );
        
        // Look for dismiss buttons specifically, avoiding generic buttons in banners
        buttons.push(...Array.from(document.querySelectorAll('[data-qa="banner"] button, [role="banner"] button')).filter(el => {
            // Skip links and link-style buttons
            if (el.tagName === 'A' || el.closest('a') || el.classList.contains('c-link--button')) {
                return false;
            }
            
            // Skip if it contains a link or preferences text
            if (el.textContent.toLowerCase().includes('preferences') ||
                el.textContent.toLowerCase().includes('settings') ||
                el.querySelector('a')) {
                return false;
            }
            
            // Look for dismiss indicators
            const text = el.textContent.trim().toLowerCase();
            const ariaLabel = (el.getAttribute('aria-label') || '').toLowerCase();
            
            return text === 'x' || text === '×' || text === '✕' || 
                   text.includes('dismiss') || text.includes('close') ||
                   ariaLabel.includes('dismiss') || ariaLabel.includes('close');
        }));
        
        // Notification-specific close buttons (not general UI close buttons)
        buttons.push(...Array.from(document.querySelectorAll('button')).filter(el => {
            // Must be within a notification context
            const parent = el.closest('[data-qa*="notification"]') || 
                          el.closest('[data-qa*="banner"]') ||
                          el.closest('[role="banner"]') ||
                          el.closest('[data-qa="notifications_prompt"]');
            
            if (!parent) return false;
            
            const text = el.textContent.trim();
            const ariaLabel = el.getAttribute('aria-label') || '';
            
            return (text === 'X' || text === '×' || text === '✕' || text === 'x') ||
                   ariaLabel.toLowerCase().includes('close') ||
                   ariaLabel.toLowerCase().includes('dismiss');
        }));
        
        // Enable notifications buttons FIRST (before any close buttons)
        buttons.push(...Array.from(document.querySelectorAll('button.c-link--button')).filter(el => {
            const text = el.textContent.toLowerCase();
            return (text.includes('enable notifications') ||
                    text.includes('enable desktop notifications') ||
                    text === 'turn on') &&
                   !text.includes('preferences') &&
                   !text.includes('settings') &&
                   !text.includes('later');  // Avoid "I'll do it later" button
        }));
        
        // Notification prompt elements
        buttons.push(
            document.querySelector('button[data-qa="notifications_prompt_enable"]'),
            document.querySelector('div[data-qa="notifications_prompt"] button:not(a)')
        );
        
        // "Got it" style buttons ONLY in notification contexts
        buttons.push(...Array.from(document.querySelectorAll('button:not(a)')).filter(el => {
            // Must be within a notification context
            const parent = el.closest('[data-qa*="notification"]') || 
                          el.closest('[data-qa*="banner"]') ||
                          el.closest('[role="banner"]') ||
                          el.closest('[data-qa="notifications_prompt"]');
            
            if (!parent) return false;
            
            // Skip link-style buttons
            if (el.classList.contains('c-link--button') || 
                el.textContent.toLowerCase().includes('preferences') ||
                el.textContent.toLowerCase().includes('settings')) {
                return false;
            }
            
            return el.textContent.toLowerCase().includes('got it') ||
                   el.textContent.toLowerCase().includes('dismiss') ||
                   el.textContent === 'OK';
        }));
        
        // Filter out nulls and already clicked
        buttons = buttons.filter(b => b !== null && b !== undefined);
        
        // Find first button we haven't clicked yet
        let button = buttons.find(b => !clickedButtons.has(b));
        
        if(button) {
            foundInitialNotifications = true;
            consecutiveEmptyAttempts = 0;
            
            // Skip if this is actually a link
            if (button.tagName === 'A' || button.closest('a')) {
                clickedButtons.add(button);
            } else {
                // Mark as clicked
                clickedButtons.add(button);
                
                // Try to click
                try {
                    button.click();
                } catch(e) {
                    button.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
                }
            }
        } else {
            consecutiveEmptyAttempts++;
            
            // If we found notifications before and now haven't seen any for 3 attempts (1.5 seconds), stop
            if (foundInitialNotifications && consecutiveEmptyAttempts >= 3) {
                clearInterval(waitForButton);
                return;
            }
        }
        
        // Stop after 5 seconds if we never found any notifications
        if (attempts >= 10 && !foundInitialNotifications) {
            clearInterval(waitForButton);
        }
    }, 500);
})();
