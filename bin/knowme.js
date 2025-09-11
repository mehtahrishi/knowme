#!/usr/bin/env node

const { spawn } = require('child_process');
const os = require('os');
const path = require('path');

// Check if Python knowme is installed
function checkPythonKnowme() {
    return new Promise((resolve) => {
        const python = spawn('python3', ['-c', 'import knowme; print("OK")'], { stdio: 'pipe' });
        python.on('close', (code) => {
            resolve(code === 0);
        });
    });
}

// Install Python knowme via pip
function installPythonKnowme() {
    console.log('Installing knowme via pip...');
    const pip = spawn('pip3', ['install', 'knowme'], { stdio: 'inherit' });
    return new Promise((resolve) => {
        pip.on('close', (code) => {
            resolve(code === 0);
        });
    });
}

// Run Python knowme
function runKnowme() {
    const python = spawn('python3', ['-c', 'from knowme.__main__ import main; main()'], { 
        stdio: 'inherit' 
    });
    python.on('close', (code) => {
        process.exit(code);
    });
}

async function main() {
    const hasKnowme = await checkPythonKnowme();
    
    if (!hasKnowme) {
        console.log('KnowMe Python package not found. Installing...');
        const installed = await installPythonKnowme();
        if (!installed) {
            console.error('Failed to install knowme. Please install manually: pip3 install knowme');
            process.exit(1);
        }
    }
    
    runKnowme();
}

main().catch(console.error);
