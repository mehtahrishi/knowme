document.addEventListener('DOMContentLoaded', () => {
    // --- DARK MODE TOGGLE ---
    const themeToggle = document.getElementById('theme-toggle');
    const themeIcon = document.getElementById('theme-icon');
    const body = document.body;

    // Check for saved theme preference or respect OS preference
    const savedTheme = localStorage.getItem('theme');
    const prefersDarkScheme = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    // Set initial theme
    if (savedTheme === 'dark' || (!savedTheme && prefersDarkScheme)) {
        body.classList.add('dark-mode');
        themeIcon.textContent = '☀️';
    } else {
        themeIcon.textContent = '🌙';
    }

    // Toggle theme function
    themeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-mode');
        
        if (body.classList.contains('dark-mode')) {
            themeIcon.textContent = '☀️';
            localStorage.setItem('theme', 'dark');
        } else {
            themeIcon.textContent = '🌙';
            localStorage.setItem('theme', 'light');
        }
    });

    // --- COPY BUTTON LOGIC ---
    const copyButtons = document.querySelectorAll('.copy-btn');

    const genericCopyIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M9 16.17L4.83 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z"/></svg>';
    const checkmarkIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>';

    const packageIcons = {
        "pip": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M9.4 16.6L4.8 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z"/></svg>', // Code icon for Python
        "deb": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z"/></svg>', // Download icon for Debian
        "snap": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M20 4h-4V2h-4v2H8V2H4v2H0v18h24V4h-4zM4 20V6h16v14H4zm2-10h2v2H6v-2zm0 4h2v2H6v-2zm4-4h2v2h-2v-2zm0 4h2v2h-2v-2zm4-4h2v2h-2v-2zm0 4h2v2h-2v-2z"/></svg>', // Package icon for Snap
        "apt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4V8h16v10zM6 10h2v2H6zm0 4h2v2H6zm4-4h8v2h-8zm0 4h8v2h-8z"/></svg>', // Terminal icon for APT
        "yay": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z"/></svg>', // Download icon for YAY
        "generic": checkmarkIcon // For the usage section
    };

    copyButtons.forEach(button => {
        const packageManager = button.dataset.packageManager;
        const originalIcon = button.innerHTML; // Store the initial copy icon SVG

        button.addEventListener('click', () => {
            const codeBlock = button.parentElement;
            const code = codeBlock.querySelector('pre code').innerText;
            navigator.clipboard.writeText(code).then(() => {
                // Change to specific icon or checkmark
                button.innerHTML = packageIcons[packageManager] || checkmarkIcon;
                
                // Add Kendo-like animation effect
                button.style.transform = 'scale(1.2)';
                button.style.transition = 'all 0.3s ease';
                
                setTimeout(() => {
                    button.style.transform = 'scale(1)';
                }, 300);

                setTimeout(() => {
                    button.innerHTML = originalIcon; // Revert to original copy icon
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy: ', err);
                // Show error state
                button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>';
                setTimeout(() => {
                    button.innerHTML = originalIcon;
                }, 2000);
            });
        });
    });

    // --- ANIMATION LOGIC ---
    // Remove the previous animation logic that was causing cards to disappear
    // Instead, we'll add a simple fade-in animation for cards when they come into view
    
    const cards = document.querySelectorAll('.card, .info-list li');
    
    // Set initial state for all cards (visible)
    cards.forEach(card => {
        card.style.opacity = '1';
        card.style.transform = 'translateY(0)';
    });
    
    // Optional: Add intersection observer for fade-in effects when scrolling
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, {
        threshold: 0.1
    });

    // Apply initial hidden state and observe
    cards.forEach(card => {
        // Only apply to cards that are not in the hero section
        if (!card.closest('.hero')) {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            observer.observe(card);
        }
    });

    // --- SMOOTH SCROLLING FOR ANCHOR LINKS ---
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // --- ADDITIONAL INTERACTIONS ---
    // Add hover effects to feature cards
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px)';
            this.style.transition = 'all 0.3s ease';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });

    // Add ripple effect to buttons
    const buttons = document.querySelectorAll('.btn, .copy-btn');
    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            // Remove any existing ripples
            const existingRipples = this.querySelectorAll('.ripple');
            existingRipples.forEach(ripple => ripple.remove());
            
            const ripple = document.createElement('span');
            ripple.classList.add('ripple');
            this.appendChild(ripple);
            
            const d = Math.max(this.clientWidth, this.clientHeight);
            ripple.style.width = ripple.style.height = d + 'px';
            
            const rect = this.getBoundingClientRect();
            ripple.style.left = e.clientX - rect.left - d/2 + 'px';
            ripple.style.top = e.clientY - rect.top - d/2 + 'px';
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });
});

// --- KEYFRAMES INJECTION ---
const styleSheet = document.styleSheets[0];
if (styleSheet) {
    try {
        styleSheet.insertRule(`
        @keyframes ripple {
            0% {
                transform: scale(0);
                opacity: 1;
            }
            100% {
                transform: scale(2);
                opacity: 0;
            }
        }`, styleSheet.cssRules.length);
        
        styleSheet.insertRule(`
        .ripple {
            position: absolute;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.7);
            transform: scale(0);
            animation: ripple 0.6s linear;
            pointer-events: none;
        }`, styleSheet.cssRules.length);
    } catch (e) {
        console.warn("Could not insert CSS keyframes dynamically: ", e);
    }
}