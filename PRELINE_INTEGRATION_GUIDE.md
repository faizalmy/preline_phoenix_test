# Preline UI + Phoenix LiveView Integration Guide

This guide demonstrates how to integrate Preline UI with Phoenix LiveView applications, providing a modern, accessible component library for your Phoenix projects.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Configuration](#configuration)
- [Basic Usage](#basic-usage)
- [Component Examples](#component-examples)
- [JavaScript Integration](#javascript-integration)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Overview

Preline UI is a modern, accessible component library built on Tailwind CSS. When integrated with Phoenix LiveView, it provides:

- **200+ Components** - Buttons, dropdowns, modals, forms, and more
- **Accessibility First** - ARIA compliant components
- **Dark Mode Support** - Built-in dark theme
- **Responsive Design** - Mobile-first approach
- **Zero Dependencies** - Works with Phoenix's asset pipeline

## Installation

### 1. Install Preline UI

```bash
cd assets
npm install preline
```

### 2. Update CSS Configuration

Add Preline imports to your `assets/css/app.css`:

```css
/* See the Tailwind configuration guide for advanced usage
   https://tailwindcss.com/docs/configuration */

@import "tailwindcss" source(none);
@source "../css";
@source "../js";
@source "../../lib/preline_phoenix_test_web";

/* Preline UI */
@source "../node_modules/preline/dist/*.js";
@import "../node_modules/preline/variants.css";

/* Plugins */
@plugin "@tailwindcss/forms";

/* Your existing plugins... */
```

### 3. Update JavaScript Configuration

Add Preline import to your `assets/js/app.js`:

```javascript
// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {hooks as colocatedHooks} from "phoenix-colocated/preline_phoenix_test"
import topbar from "../vendor/topbar"

// Preline UI
import "preline"

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: {...colocatedHooks},
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// Initialize Preline components
document.addEventListener('DOMContentLoaded', () => {
  window.HSStaticMethods.autoInit();
});

// expose liveSocket on window for web console debug logs and latency simulation:
window.liveSocket = liveSocket
```

## Configuration

### Build Assets

Deploy your assets to include Preline:

```bash
mix assets.deploy
```

### Verify Installation

Check that Preline is included in your built assets:

```bash
# Check CSS
grep -i "hs-" priv/static/assets/css/app.css

# Check JavaScript
grep -i "preline" priv/static/assets/js/app.js
```

## Basic Usage

### 1. Buttons

```heex
<!-- Primary Button -->
<button type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600">
  Primary Button
</button>

<!-- Secondary Button -->
<button type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-white dark:hover:bg-neutral-700">
  Secondary Button
</button>
```

### 2. Dropdowns

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

### 3. Alerts

```heex
<!-- Success Alert -->
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

## Component Examples

### Forms

```heex
<form class="space-y-4">
  <!-- Input Field -->
  <div>
    <label for="hs-leading-icon" class="block text-sm font-medium mb-2 dark:text-white">Email</label>
    <div class="relative">
      <input type="email" id="hs-leading-icon" name="hs-leading-icon" class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600" placeholder="Enter your email">
      <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none z-20 ps-4">
        <svg class="flex-shrink-0 size-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
      </div>
    </div>
  </div>

  <!-- Select Field -->
  <div>
    <label for="hs-select-label" class="block text-sm font-medium mb-2 dark:text-white">Country</label>
    <select id="hs-select-label" class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600">
      <option selected>Choose country</option>
      <option>United States</option>
      <option>Canada</option>
      <option>United Kingdom</option>
    </select>
  </div>
</form>
```

### Modals

```heex
<!-- Modal Trigger Button -->
<button type="button" class="py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-green-600 text-white hover:bg-green-700 disabled:opacity-50 disabled:pointer-events-none dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600" data-hs-overlay="#hs-modal-basic">
  Open Modal
</button>

<!-- Modal Component -->
<div id="hs-modal-basic" class="hs-overlay hidden size-full fixed top-0 start-0 z-[80] overflow-x-hidden overflow-y-auto">
  <div class="hs-overlay-open:mt-7 hs-overlay-open:opacity-100 hs-overlay-open:duration-500 mt-0 opacity-0 ease-out transition-all sm:max-w-lg sm:w-full m-3 sm:mx-auto">
    <div class="flex flex-col bg-white border shadow-sm rounded-xl dark:bg-neutral-800 dark:border-neutral-700 dark:shadow-neutral-700/70">
      <div class="flex justify-between items-center py-3 px-4 border-b dark:border-neutral-700">
        <h3 class="font-bold text-gray-800 dark:text-white">
          Modal title
        </h3>
        <button type="button" class="flex justify-center items-center size-7 text-sm font-semibold rounded-full border border-transparent text-gray-800 hover:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none dark:text-white dark:hover:bg-neutral-700" data-hs-overlay="#hs-modal-basic">
          <span class="sr-only">Close</span>
          <svg class="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m18 6-12 12"/><path d="m6 6 12 12"/></svg>
        </button>
      </div>
      <div class="p-4 overflow-y-auto">
        <p class="mt-1 text-gray-800 dark:text-neutral-400">
          This is a wider card with supporting text below as a natural lead-in to additional content.
        </p>
      </div>
      <div class="flex justify-end items-center gap-x-2 py-3 px-4 border-t dark:border-neutral-700">
        <button type="button" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-white dark:hover:bg-neutral-700" data-hs-overlay="#hs-modal-basic">
          Close
        </button>
        <button type="button" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600">
          Save changes
        </button>
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

### Manual Initialization

For dynamic content or LiveView updates, manually initialize components:

```javascript
// Initialize specific component
HSDropdown.autoInit();

// Initialize all components
window.HSStaticMethods.autoInit();
```

### LiveView Integration

For LiveView updates, reinitialize components after DOM changes:

```javascript
// In your LiveView hooks or after DOM updates
window.addEventListener("phx:update", () => {
  window.HSStaticMethods.autoInit();
});
```

## Best Practices

### 1. Component Structure

- Always use the complete Preline HTML structure
- Include all required CSS classes
- Maintain proper ARIA attributes for accessibility

### 2. Styling

- Use Preline's utility classes for consistent styling
- Leverage dark mode classes for theme support
- Follow the component documentation for proper styling

### 3. JavaScript

- Let Preline handle component initialization
- Don't manually manipulate component states
- Use Preline's API for programmatic control

### 4. Performance

- Build assets with `mix assets.deploy` for production
- Use the minified versions in production
- Consider lazy loading for heavy components

## Troubleshooting

### Common Issues

#### 1. Components Not Working

**Problem**: Dropdowns, modals, or other interactive components don't respond to clicks.

**Solution**:
- Ensure Preline JavaScript is loaded: `import "preline"`
- Check that auto-initialization is called
- Verify the component HTML structure matches the documentation

#### 2. Styling Issues

**Problem**: Components don't look correct or are missing styles.

**Solution**:
- Verify Preline CSS is imported: `@import "../node_modules/preline/variants.css"`
- Check that Tailwind CSS is properly configured
- Ensure assets are built: `mix assets.deploy`

#### 3. Dark Mode Not Working

**Problem**: Dark mode styles aren't applied.

**Solution**:
- Include dark mode classes in your components
- Ensure your theme toggle is properly configured
- Check that dark mode CSS is included in the build

#### 4. LiveView Updates

**Problem**: Components don't work after LiveView updates.

**Solution**:
- Reinitialize components after DOM updates
- Use LiveView hooks to trigger reinitialization
- Consider using `phx:update` events

### Debugging

#### Check Asset Loading

```bash
# Verify CSS includes Preline classes
grep -i "hs-" priv/static/assets/css/app.css

# Verify JavaScript includes Preline
grep -i "preline" priv/static/assets/js/app.js
```

#### Browser Console

```javascript
// Check if Preline is loaded
console.log(window.HSStaticMethods);

// Manually initialize components
window.HSStaticMethods.autoInit();
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

## Support

For issues specific to:
- **Preline UI**: Check the [Preline documentation](https://preline.co/docs/)
- **Phoenix LiveView**: Refer to the [Phoenix LiveView guide](https://hexdocs.pm/phoenix_live_view/)
- **This Integration**: Review this guide and the example project
