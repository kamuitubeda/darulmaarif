<template>
  <div class="min-h-screen bg-gray-50 flex flex-col font-sans">
    <AppHeader />
    
    <!-- Main content area, padding top and bottom to account for fixed header and bottom nav. -->
    <!-- Optimized for mobile layout while still being responsive on larger screens -->
    <main class="flex-1 w-full max-w-md mx-auto bg-white shadow-sm relaitve pb-pb-nav pt-pt-nav overflow-x-hidden relative min-h-screen">
      <div class="px-4 py-6">
        <slot />
      </div>
    </main>

    <BottomNavigation />
  </div>
</template>

<style>
/* Utilities for fixed nav spacing */
.pt-pt-nav {
  padding-top: 64px; /* Approximate header height */
}
.pb-pb-nav {
  padding-bottom: 72px; /* Approximate bottom nav height */
}
</style>
