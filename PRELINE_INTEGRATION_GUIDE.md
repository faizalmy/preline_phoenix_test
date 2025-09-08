# Preline UI + Phoenix LiveView Integration Guide

This guide demonstrates how to integrate Preline UI with Phoenix LiveView applications, providing a modern, accessible component library for your Phoenix projects.

## Table of Contents

- [Overview](#overview)
- [Quick Setup](#quick-setup)
- [Component Examples](#component-examples)
- [JavaScript Integration](#javascript-integration)
- [Troubleshooting](#troubleshooting)

## Overview

Preline UI is a modern, accessible component library built on Tailwind CSS. When integrated with Phoenix LiveView, it provides:

- **200+ Components** - Buttons, dropdowns, modals, forms, and more
- **Accessibility First** - ARIA compliant components
- **Dark Mode Support** - Built-in dark theme
- **Responsive Design** - Mobile-first approach
- **Zero Dependencies** - Works with Phoenix's asset pipeline

## Quick Setup

### 1. Install Preline UI

```bash
cd assets
npm install preline
```

### 2. Update CSS Configuration

Add Preline imports to your `assets/css/app.css`:

```css
/* Preline UI */
@import "../node_modules/preline/variants.css";
```

### 3. Update JavaScript Configuration

Add Preline import to your `assets/js/app.js`:

```javascript
// Preline UI
import "preline"

// Initialize Preline components
document.addEventListener('DOMContentLoaded', () => {
  window.HSStaticMethods.autoInit();
});
```

### 4. Build Assets

```bash
mix assets.deploy
```

### 5. Verify Installation

```bash
# Check CSS includes Preline classes
grep -i "hs-" priv/static/assets/css/app.css

# Check JavaScript includes Preline
grep -i "preline" priv/static/assets/js/app.js
```

## Component Examples

### Dropdown

```heex
<div class="hs-dropdown [--auto-close:inside] relative inline-flex">
  <button id="hs-dropdown-default" type="button" class="hs-dropdown-toggle py-3 px-4 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-2xs hover:bg-gray-50 focus:outline-hidden focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-white dark:hover:bg-neutral-700 dark:focus:bg-neutral-700" aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
    Actions
    <svg class="hs-dropdown-open:rotate-180 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
  </button>

  <div class="hs-dropdown-menu transition-[opacity,margin] duration hs-dropdown-open:opacity-100 opacity-0 hidden min-w-60 bg-white shadow-md rounded-lg mt-2 dark:bg-neutral-800 dark:border dark:border-neutral-700 dark:divide-neutral-700 after:h-4 after:absolute after:-bottom-4 after:start-0 after:w-full before:h-4 before:absolute before:-top-4 before:start-0 before:w-full" role="menu" aria-orientation="vertical" aria-labelledby="hs-dropdown-default">
    <div class="p-1 space-y-0.5">
      <a class="flex items-center gap-x-3.5 py-2 px-3 rounded-lg text-sm text-gray-800 hover:bg-gray-100 focus:outline-hidden focus:bg-gray-100 dark:text-neutral-400 dark:hover:bg-neutral-700 dark:hover:text-neutral-300 dark:focus:bg-neutral-700" href="#">
        Newsletter
      </a>
      <a class="flex items-center gap-x-3.5 py-2 px-3 rounded-lg text-sm text-gray-800 hover:bg-gray-100 focus:outline-hidden focus:bg-gray-100 dark:text-neutral-400 dark:hover:bg-neutral-700 dark:hover:text-neutral-300 dark:focus:bg-neutral-700" href="#">
        Purchases
      </a>
    </div>
  </div>
</div>
```

### Button

```heex
<button type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600">
  Primary Button
</button>
```

### Alert

```heex
<div class="bg-green-50 border border-green-200 text-sm text-green-800 rounded-lg p-4 dark:bg-green-800/10 dark:border-green-900/20 dark:text-green-400" role="alert">
  <div class="flex">
    <div class="flex-shrink-0">
      <svg class="flex-shrink-0 size-4 mt-0.5" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 12l2 2 4-4"/><path d="M21 12c.552 0 1-.448 1-1V5c0-.552-.448-1-1-1H3c-.552 0-1 .448-1 1v6c0 .552.448 1 1 1h18z"/></svg>
    </div>
    <div class="ms-3">
      <h3 class="text-sm font-semibold">Success Alert</h3>
      <div class="mt-2 text-sm text-green-700 dark:text-green-400">
        <p>Operation completed successfully!</p>
      </div>
    </div>
  </div>
</div>
```

## JavaScript Integration

### Auto-initialization

Preline components are automatically initialized when the DOM loads:

```javascript
document.addEventListener('DOMContentLoaded', () => {
  window.HSStaticMethods.autoInit();
});
```

### LiveView Integration

For LiveView updates, reinitialize components after DOM changes:

```javascript
// In your LiveView hooks or after DOM updates
window.addEventListener("phx:update", () => {
  window.HSStaticMethods.autoInit();
});
```

## Troubleshooting

### Components Not Working

**Problem**: Dropdowns, modals, or other interactive components don't respond to clicks.

**Solution**:
- Ensure Preline JavaScript is loaded: `import "preline"`
- Check that auto-initialization is called
- Verify the component HTML structure matches the documentation

### Styling Issues

**Problem**: Components don't look correct or are missing styles.

**Solution**:
- Verify Preline CSS is imported: `@import "../node_modules/preline/variants.css"`
- Check that Tailwind CSS is properly configured
- Ensure assets are built: `mix assets.deploy`

### LiveView Updates

**Problem**: Components don't work after LiveView updates.

**Solution**:
- Reinitialize components after DOM updates
- Use LiveView hooks to trigger reinitialization
- Consider using `phx:update` events

### Debugging

```bash
# Verify CSS includes Preline classes
grep -i "hs-" priv/static/assets/css/app.css

# Verify JavaScript includes Preline
grep -i "preline" priv/static/assets/js/app.js
```

## Resources

- [Preline UI Documentation](https://preline.co/docs/)
- [Phoenix LiveView Guide](https://hexdocs.pm/phoenix_live_view/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

## Example Project

This integration guide is based on a working example in the `preline_phoenix_test` project. You can find:

- Complete setup in `assets/css/app.css` and `assets/js/app.js`
- Working examples in `lib/preline_phoenix_test_web/controllers/page_html/preline_test.html.heex`
- Test the integration at `http://localhost:4000/preline-test`
