<template>
  <div>
    <AdminPageHeader title="Pengumuman" subtitle="Kelola berita dan informasi pesantren" @add="openModal(null)" />

    <UTable :rows="items" :columns="columns" :loading="pending" class="bg-white rounded-2xl shadow-sm border border-gray-100">
      <template #date-data="{ row }">{{ formatDate(row.date) }}</template>
      <template #is_active-data="{ row }">
        <UBadge :color="row.is_active ? 'green' : 'gray'" variant="soft">{{ row.is_active ? 'Aktif' : 'Draft' }}</UBadge>
      </template>
      <template #actions-data="{ row }">
        <div class="flex gap-2">
          <UButton size="xs" icon="i-heroicons-pencil-square" color="gray" variant="ghost" @click="openModal(row)" />
          <UButton size="xs" icon="i-heroicons-trash" color="red" variant="ghost" @click="deleteItem(row.id)" />
        </div>
      </template>
    </UTable>

    <UModal v-model="isOpen" :ui="{ width: 'sm:max-w-2xl' }">
      <UCard>
        <template #header>
          <h3 class="font-bold text-gray-800">{{ form.id ? 'Edit' : 'Tambah' }} Pengumuman</h3>
        </template>
        <form class="space-y-4" @submit.prevent="saveItem">
          <UFormGroup label="Judul" required><UInput v-model="form.title" required /></UFormGroup>
          <div class="grid grid-cols-2 gap-3">
            <UFormGroup label="Tanggal"><UInput v-model="form.date" type="date" /></UFormGroup>
            <UFormGroup label="Kategori">
              <USelect v-model="form.category" :options="['Penerimaan', 'Akademik', 'Prestasi', 'Kegiatan', 'Pengumuman']" />
            </UFormGroup>
          </div>
          <UFormGroup label="Ringkasan"><UTextarea v-model="form.summary" autoresize placeholder="Deskripsi singkat yang tampil di daftar..." /></UFormGroup>
          <UFormGroup label="Isi Konten"><UTextarea v-model="form.content" :rows="6" placeholder="Tulis isi pengumuman lengkap di sini..." /></UFormGroup>
          <UFormGroup label="URL Gambar"><UInput v-model="form.image_url" placeholder="https://..." icon="i-heroicons-link" /></UFormGroup>
          <UFormGroup label="Status"><UToggle v-model="form.is_active" label="Tampilkan di portal" /></UFormGroup>
          <div class="flex justify-end gap-2 pt-2">
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
const defaultForm = () => ({ id: null, title: '', summary: '', content: '', category: 'Pengumuman', image_url: '', date: new Date().toISOString().slice(0,10), is_active: true })
const form = ref(defaultForm())
const columns = [
  { key: 'title', label: 'Judul' },
  { key: 'category', label: 'Kategori' },
  { key: 'date', label: 'Tanggal' },
  { key: 'is_active', label: 'Status' },
  { key: 'actions', label: '' },
]
const { data: items, pending, refresh } = await useAsyncData('admin-announcements', () =>
  supabase.from('announcements').select('*').order('date', { ascending: false }).then(r => r.data ?? [])
)
const openModal = (row) => { form.value = row ? { ...row } : defaultForm(); isOpen.value = true }
const saveItem = async () => {
  saving.value = true
  const { id, ...data } = form.value
  if (id) await supabase.from('announcements').update(data).eq('id', id)
  else await supabase.from('announcements').insert(data)
  saving.value = false; isOpen.value = false; refresh()
}
const deleteItem = async (id) => { if (!confirm('Hapus pengumuman ini?')) return; await supabase.from('announcements').delete().eq('id', id); refresh() }
const formatDate = (d) => d ? new Intl.DateTimeFormat('id-ID', { day: 'numeric', month: 'short', year: 'numeric' }).format(new Date(d)) : ''
</script>
