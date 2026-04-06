<template>
  <div class="mb-8">
    <div class="flex items-center justify-between mb-4">
      <h3 class="font-bold text-gray-800 flex items-center gap-2">
        <UIcon name="i-heroicons-newspaper" class="w-5 h-5 text-green-600" />
        Pengumuman Terbaru
      </h3>
      <UButton variant="ghost" color="green" size="xs" trailing-icon="i-heroicons-arrow-right" to="/pengumuman">Semua</UButton>
    </div>

    <!-- Loading -->
    <div v-if="pending" class="py-6 flex justify-center">
      <UIcon name="i-heroicons-arrow-path" class="w-6 h-6 text-green-400 animate-spin" />
    </div>

    <div v-else-if="announcements && announcements.length > 0" class="space-y-3">
      <div
        v-for="item in announcements"
        :key="item._path"
        class="bg-white rounded-xl overflow-hidden shadow-sm border border-gray-100 flex flex-col active:scale-[0.98] transition-all duration-200 hover:shadow-md cursor-pointer group tap-highlight-transparent"
        @click="navigateTo(item._path)"
      >
        <!-- Image Thumbnail -->
        <div v-if="item.image" class="h-32 w-full bg-gray-100 overflow-hidden">
          <img :src="item.image" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" />
        </div>
        <div class="p-4">
          <div class="flex items-center justify-between mb-2">
            <span class="text-[10px] font-extrabold text-green-600 tracking-wider uppercase">{{ item.category || 'Pengumuman' }}</span>
            <span class="text-[10px] text-gray-400 font-medium">{{ formatDate(item.date) }}</span>
          </div>
          <h4 class="text-sm font-bold text-gray-800 leading-snug mb-1 group-hover:text-green-700 transition-colors line-clamp-2">
            {{ item.title }}
          </h4>
          <p class="text-xs text-gray-500 line-clamp-2 leading-relaxed">{{ item.summary }}</p>
        </div>
      </div>
    </div>

    <div v-else class="bg-gray-50 rounded-xl p-6 text-center border border-gray-100 border-dashed">
      <UIcon name="i-heroicons-megaphone" class="w-8 h-8 text-gray-300 mx-auto mb-2" />
      <p class="text-sm text-gray-500 font-medium">Belum ada pengumuman terbaru</p>
    </div>
  </div>
</template>

<script setup>
const { data: announcements, pending } = useAsyncData('home-announcements', () =>
  queryContent('/pengumuman')
    .sort({ date: -1 })
    .limit(3)
    .find()
)

const formatDate = (dateStr) => {
  if (!dateStr) return ''
  return new Intl.DateTimeFormat('id-ID', { day: 'numeric', month: 'short', year: 'numeric' }).format(new Date(dateStr))
}
</script>

<style scoped>
.tap-highlight-transparent {
  -webkit-tap-highlight-color: transparent;
}
</style>
