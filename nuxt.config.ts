// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  devtools: { enabled: true },
  modules: ['@nuxt/ui', '@nuxt/content', '@nuxtjs/supabase'],
  supabase: {
    redirect: false
  },
  routeRules: {
    '/admin/**': { ssr: false } // Admin panel runs client-side only
  },
  future: {
    compatibilityVersion: 4,
  },
  colorMode: {
    preference: 'light' // default to light mode for an institution site, they can toggle it later
  },
  nitro: {
    preset: "cloudflare-pages"
  }
})
