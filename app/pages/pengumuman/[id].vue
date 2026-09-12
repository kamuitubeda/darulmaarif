<template>
  <div class="pb-10 -mx-4 sm:mx-0 px-4 sm:px-0">
    <!-- Back Navigation -->
    <div class="flex items-center gap-2 mb-4">
      <UButton icon="i-heroicons-arrow-left" color="gray" variant="ghost" to="/pengumuman" />
      <span class="text-sm font-bold text-gray-500 uppercase tracking-wide">Kembali</span>
    </div>

    <!-- Loading -->
    <div v-if="pending" class="py-16 flex flex-col items-center gap-3">
      <UIcon name="i-heroicons-arrow-path" class="w-8 h-8 text-green-500 animate-spin" />
      <p class="text-sm text-gray-400 font-medium">Memuat pengumuman...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="error || !doc" class="py-16 bg-gray-50 rounded-2xl flex flex-col items-center justify-center border border-dashed border-gray-200">
      <UIcon name="i-heroicons-exclamation-triangle" class="w-14 h-14 text-gray-200 mb-3" />
      <p class="text-gray-400 font-semibold text-sm">Pengumuman tidak ditemukan.</p>
    </div>

    <!-- Article Content -->
    <div v-else class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
      
      <!-- Hero Thumbnail -->
      <div v-if="doc.image_url" class="w-full h-48 sm:h-72 bg-gray-100 relative">
        <img :src="doc.image_url" :alt="doc.title" class="w-full h-full object-cover" />
        <div class="absolute inset-0 bg-gradient-to-t from-gray-900/60 to-transparent"></div>
        
        <!-- Floating Date & Category -->
        <div class="absolute bottom-4 left-4 right-4 flex justify-between items-end">
          <span class="bg-white/20 backdrop-blur-md text-white px-3 py-1 text-[10px] font-bold uppercase tracking-widest rounded shadow-sm border border-white/20">
            {{ doc.category }}
          </span>
        </div>
      </div>

      <!-- Article Header & Body -->
      <div class="p-5 sm:p-8">
        <div class="mb-6 border-b border-gray-100 pb-6">
          <h1 class="text-2xl sm:text-3xl font-extrabold text-gray-800 leading-tight mb-2">
            {{ doc.title }}
          </h1>
          <div class="flex items-center gap-2 text-xs font-semibold text-gray-500">
            <UIcon name="i-heroicons-clock" class="w-4 h-4 text-green-500" />
            <span>Diterbitkan: {{ formatDate(doc.date) }}</span>
          </div>
        </div>

        <div class="prose prose-sm sm:prose-base max-w-none text-gray-700 whitespace-pre-wrap">
          {{ doc.content || doc.summary }}
        </div>
      </div>

      <!-- Share Actions -->
      <div class="bg-gray-50 p-4 border-t border-gray-100 flex items-center justify-between">
        <span class="text-xs font-bold text-gray-500">Bagikan pengumuman:</span>
        <div class="flex gap-2">
          <UButton icon="i-heroicons-share" color="green" variant="soft" size="xs" class="rounded-full" />
          <UButton icon="i-heroicons-bookmark" color="gray" variant="soft" size="xs" class="rounded-full" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute()
const supabase = useSupabaseClient()

const { data: doc, pending, error } = await useAsyncData(`announcement-${route.params.id}`, () =>
  supabase.from('announcements')
    .select('*')
    .eq('id', route.params.id)
    .single()
    .then(r => r.data)
)

if (doc.value) {
  useHead({
    title: `${doc.value.title} - Darul Maarif`
  })
}

// Date formatting helper
const formatDate = (dateStr) => {
  if (!dateStr) return ''
  return new Intl.DateTimeFormat('id-ID', { year: 'numeric', month: 'long', day: 'numeric' }).format(new Date(dateStr))
}
</script>
