<template>
  <div class="pb-4">
    <!-- 1. Hero slider for important announcements -->
    <HomeHeroSlider :slides="mockSlides" />

    <!-- 2. Quick menu grid (8 items) -->
    <HomeQuickMenu />

    <!-- 3. Weekly agenda preview -->
    <HomeAgendaPreview :items="mockAgendas" />

    <!-- 4. Latest information / announcements preview -->
    <HomeAnnouncementPreview />

    <!-- 5. Latest gallery preview -->
    <HomeGalleryPreview :items="mockGalleries" />

    <!-- 6. Call-to-action section for PSB registration -->
    <HomePSBCallToAction />
  </div>
</template>

<script setup>
// Using auto-imported components from ~/components/home/*
definePageMeta({
  title: 'Beranda - Darul Maarif'
})

const supabase = useSupabaseClient()

const { data: dbSlides } = await useAsyncData('home-slides', () =>
  supabase.from('announcements')
    .select('id, title, summary, image_url, category')
    .eq('is_active', true)
    .order('date', { ascending: false })
    .limit(4)
    .then(r => r.data ?? [])
)

const mockSlides = computed(() => {
  return (dbSlides.value || []).map((item, index) => ({
    title: item.title,
    description: item.summary,
    image: item.image_url || 'https://picsum.photos/seed/pesantren1/600/300',
    link: `/pengumuman/${item.id}`,
    order: index + 1,
    is_active: true
  }))
})

const { data: dbAgendas } = await useAsyncData('home-agendas', () =>
  supabase.from('agendas')
    .select('*')
    .eq('is_active', true)
    .gte('date', new Date().toISOString().slice(0, 10))
    .order('date', { ascending: true })
    .limit(3)
    .then(r => r.data ?? [])
)

const mockAgendas = computed(() => {
  return (dbAgendas.value || []).map(item => {
    const d = new Date(item.date)
    return {
      ...item,
      date_day: new Intl.DateTimeFormat('id-ID', { day: '2-digit' }).format(d),
      date_month: new Intl.DateTimeFormat('id-ID', { month: 'short' }).format(d),
      link: `/agenda`
    }
  })
})

const { data: mockGalleries } = await useAsyncData('home-galleries', () =>
  supabase.from('gallery')
    .select('*')
    .eq('is_active', true)
    .order('created_at', { ascending: false })
    .limit(4)
    .then(r => r.data ?? [])
)
</script>
