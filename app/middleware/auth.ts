export default defineNuxtRouteMiddleware((to) => {
  const user = useSupabaseUser()
  
  // Only protect /admin/* routes (except /admin/login)
  if (to.path.startsWith('/admin') && to.path !== '/admin/login') {
    if (!user.value) {
      return navigateTo('/admin/login')
    }
  }
  
  // If already logged in, redirect away from login
  if (to.path === '/admin/login' && user.value) {
    return navigateTo('/admin')
  }
})
