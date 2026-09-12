<template>
  <div>
    <AdminPageHeader title="Daftar Agenda" subtitle="Kelola jadwal kegiatan pesantren" @add="openModal(null)" />

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

    <!-- Modal -->
    <UModal v-model="isOpen">
      <UCard>
        <template #header>
          <h3 class="font-bold text-gray-800">{{ form.id ? 'Edit' : 'Tambah' }} Agenda</h3>
        </template>
        <form class="space-y-4" @submit.prevent="saveItem">
          <UFormGroup label="Judul" required><UInput v-model="form.title" required /></UFormGroup>
          <UFormGroup label="Tanggal" required><UInput v-model="form.date" type="date" required /></UFormGroup>
          <UFormGroup label="Waktu"><UInput v-model="form.time" placeholder="07.00 - 09.00 WIB" /></UFormGroup>
          <UFormGroup label="Lokasi"><UInput v-model="form.location" /></UFormGroup>
          <UFormGroup label="Kategori">
            <USelect v-model="form.category" :options="['Akademik', 'Kajian', 'Ekstrakurikuler', 'Acara', 'Umum']" />
          </UFormGroup>
          <UFormGroup label="Deskripsi"><UTextarea v-model="form.description" autoresize /></UFormGroup>
          <UFormGroup label="Status">
            <UToggle v-model="form.is_active" label="Tampilkan di portal" />
          </UFormGroup>
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
import { ref } from 'vue'
definePageMeta({ layout: 'admin', middleware: 'auth' })

const supabase = useSupabaseClient()
const isOpen = ref(false)
const saving = ref(false)

const defaultForm = () => ({ id: null, title: '', date: '', time: '', location: '', category: 'Umum', description: '', is_active: true })
const form = ref(defaultForm())

const columns = [
  { key: 'title', label: 'Judul' },
  { key: 'date', label: 'Tanggal' },
  { key: 'category', label: 'Kategori' },
  { key: 'location', label: 'Lokasi' },
  { key: 'is_active', label: 'Status' },
  { key: 'actions', label: '' },
]

const { data: items, pending, refresh } = await useAsyncData('admin-agendas', () =>
  supabase.from('agendas').select('*').order('date', { ascending: false }).then(r => r.data ?? [])
)

const openModal = (row) => {
  form.value = row ? { ...row } : defaultForm()
  isOpen.value = true
}

const saveItem = async () => {
  saving.value = true
  const { id, ...data } = form.value
  if (id) {
    await supabase.from('agendas').update(data).eq('id', id)
  } else {
    await supabase.from('agendas').insert(data)
  }
  saving.value = false
  isOpen.value = false
  refresh()
}

const deleteItem = async (id) => {
  if (!confirm('Hapus agenda ini?')) return
  await supabase.from('agendas').delete().eq('id', id)
  refresh()
}

const formatDate = (d) => d ? new Intl.DateTimeFormat('id-ID', { day: 'numeric', month: 'short', year: 'numeric' }).format(new Date(d)) : ''
</script>
