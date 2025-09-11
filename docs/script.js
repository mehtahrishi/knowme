document.addEventListener('DOMContentLoaded', () => {
    // --- COPY BUTTON LOGIC ---
    const copyButtons = document.querySelectorAll('.copy-btn');

    const genericCopyIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"/></svg>';
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

                setTimeout(() => {
                    button.innerHTML = originalIcon; // Revert to original copy icon
                }, 2000);
            });
        });
    });

    // --- ANIMATION LOGIC ---
    const cards = document.querySelectorAll('.card, .info-list li');
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animation = 'fadeInUp 0.5s ease-out forwards';
            }
        });
    }, {
        threshold: 0.1
    });

    cards.forEach(card => {
        card.style.opacity = '0';
        observer.observe(card);
    });
});

// --- KEYFRAMES INJECTION ---
const styleSheet = document.styleSheets[0];
if (styleSheet) {
    try {
        styleSheet.insertRule(`
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }`, styleSheet.cssRules.length);
    } catch (e) {
        console.warn("Could not insert CSS keyframes dynamically: ", e);
    }
}
