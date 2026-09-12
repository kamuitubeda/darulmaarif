<template>
  <div>
    <AdminPageHeader title="Galeri Foto" subtitle="Kelola foto dan dokumentasi kegiatan" @add="openModal(null)" />

    <!-- Gallery Grid -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3 mb-4">
      <div v-for="item in items" :key="item.id" class="group relative bg-white rounded-2xl overflow-hidden shadow-sm border border-gray-100">
        <img :src="item.image_url" :alt="item.title" class="w-full aspect-square object-cover" />
        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/40 transition-colors flex items-center justify-center gap-2 opacity-0 group-hover:opacity-100">
          <UButton size="xs" icon="i-heroicons-pencil-square" color="white" variant="solid" @click="openModal(item)" />
          <UButton size="xs" icon="i-heroicons-trash" color="red" variant="solid" @click="deleteItem(item.id)" />
        </div>
        <div class="p-2">
          <p class="text-xs font-semibold text-gray-700 line-clamp-1">{{ item.title }}</p>
          <span class="text-[10px] text-gray-400">{{ item.category }}</span>
        </div>
      </div>

      <div v-if="pending" v-for="n in 4" :key="n" class="bg-gray-100 rounded-2xl aspect-square animate-pulse"></div>
    </div>

    <UModal v-model="isOpen">
      <UCard>
        <template #header><h3 class="font-bold">{{ form.id ? 'Edit' : 'Tambah' }} Foto</h3></template>
        <form class="space-y-4" @submit.prevent="saveItem">
          <UFormGroup label="Judul" required><UInput v-model="form.title" required /></UFormGroup>
          <UFormGroup label="URL Gambar" required help="Gunakan link gambar dari Supabase Storage atau URL eksternal">
            <UInput v-model="form.image_url" placeholder="https://..." required />
          </UFormGroup>
          <UFormGroup label="Kategori">
            <USelect v-model="form.category" :options="['Fasilitas', 'Akademik', 'Ekstrakurikuler', 'Acara', 'Umum']" />
          </UFormGroup>
          <UFormGroup label="Status"><UToggle v-model="form.is_active" label="Tampilkan di portal" /></UFormGroup>
          <div class="flex justify-end gap-2">
            <UButton color="gray" variant="ghost" @click="isOpen = false">Batal</UButton>
            <UButton type="submit" color="green" :loading="saving">Simpan</UButton>
          </div>
        </form>
      </UCard>
    </UModal>
  </div>
</template>

<script setup>
definePageMeta({ layout: 'admin', middleware: 'auth' })
const supabase = useSupabaseClient()
const isOpen = ref(false)
const saving = ref(false)
const defaultForm = () => ({ id: null, title: '', image_url: '', category: 'Umum', is_active: true })
const form = ref(defaultForm())
const { data: items, pending, refresh } = await useAsyncData('admin-gallery', () =>
  supabase.from('gallery').select('*').order('created_at', { ascending: false }).then(r => r.data ?? [])
)
const openModal = (row) => { form.value = row ? { ...row } : defaultForm(); isOpen.value = true }
const saveItem = async () => {
  saving.value = true
  const { id, ...data } = form.value
  if (id) await supabase.from('gallery').update(data).eq('id', id)
  else await supabase.from('gallery').insert(data)
  saving.value = false; isOpen.value = false; refresh()
}
const deleteItem = async (id) => { if (!confirm('Hapus foto ini?')) return; await supabase.from('gallery').delete().eq('id', id); refresh() }
</script>
