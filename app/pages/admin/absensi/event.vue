<template>
  <div>
    <AdminPageHeader 
      title="Master Event Absensi" 
      description="Kelola daftar kegiatan rutin dan insidental yang membutuhkan absensi."
      icon="i-heroicons-clipboard-document-list"
    >
      <template #actions>
        <UButton color="green" icon="i-heroicons-plus" @click="openModal()">
          Tambah Event
        </UButton>
      </template>
    </AdminPageHeader>

    <UCard>
      <UTable :columns="columns" :rows="events" :loading="pending">
        <template #type-data="{ row }">
          <UBadge :color="row.type === 'Rutin' ? 'blue' : 'orange'" variant="soft">
            {{ row.type }}
          </UBadge>
        </template>
        <template #actions-data="{ row }">
          <div class="flex gap-2">
            <UButton color="blue" variant="soft" icon="i-heroicons-pencil-square" size="xs" @click="openModal(row)" />
            <UButton color="red" variant="soft" icon="i-heroicons-trash" size="xs" @click="confirmDelete(row)" />
          </div>
        </template>
      </UTable>
    </UCard>

    <!-- Modal Form -->
    <UModal v-model="isModalOpen">
      <UCard>
        <template #header>
          <div class="flex items-center justify-between">
            <h3 class="text-base font-semibold leading-6 text-gray-900">
              {{ editingId ? 'Edit Event' : 'Tambah Event' }}
            </h3>
            <UButton color="gray" variant="ghost" icon="i-heroicons-x-mark-20-solid" class="-my-1" @click="isModalOpen = false" />
          </div>
        </template>
        
        <form @submit.prevent="saveEvent" class="space-y-4">
          <UFormGroup label="Nama Event" required>
            <UInput v-model="form.name" placeholder="Misal: Sholat Dhuha, KBM, atau UTS Ganjil" required />
          </UFormGroup>
          <UFormGroup label="Tipe Event" required>
            <USelect v-model="form.type" :options="['Rutin', 'Insidental']" required />
          </UFormGroup>
          <UFormGroup label="Keterangan">
            <UTextarea v-model="form.description" placeholder="Deskripsi singkat tentang event absensi ini" />
          </UFormGroup>
          
          <div class="flex justify-end gap-3 mt-6">
            <UButton color="gray" variant="soft" @click="isModalOpen = false">Batal</UButton>
            <UButton type="submit" color="green" :loading="isSaving">Simpan</UButton>
          </div>
        </form>
      </UCard>
    </UModal>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const supabase = useSupabaseClient()
const toast = useToast()

useHead({
  title: `Master Event Absensi - Admin Darul Maarif`
})

const columns = [
  { key: 'name', label: 'Nama Event', sortable: true },
  { key: 'type', label: 'Tipe', sortable: true },
  { key: 'description', label: 'Keterangan' },
  { key: 'actions', label: 'Aksi' }
]

const { data: events, pending, refresh } = useAsyncData('attendance-events', () =>
  supabase.from('attendance_events')
    .select('*')
    .order('created_at', { ascending: false })
    .then(r => r.data ?? [])
)

// Modal & Form State
const isModalOpen = ref(false)
const isSaving = ref(false)
const editingId = ref(null)
const form = ref({
  name: '',
  type: 'Rutin',
  description: ''
})

const openModal = (item = null) => {
  if (item) {
    editingId.value = item.id
    form.value = { ...item }
  } else {
    editingId.value = null
    form.value = {
      name: '',
      type: 'Rutin',
      description: ''
    }
  }
  isModalOpen.value = true
}

const saveEvent = async () => {
  isSaving.value = true
  try {
    const payload = { ...form.value }
    if (editingId.value) {
      const { error } = await supabase.from('attendance_events').update(payload).eq('id', editingId.value)
      if (error) throw error
      toast.add({ title: 'Berhasil', description: 'Event absensi diperbarui.', color: 'green' })
    } else {
      const { error } = await supabase.from('attendance_events').insert(payload)
      if (error) throw error
      toast.add({ title: 'Berhasil', description: 'Event absensi baru ditambahkan.', color: 'green' })
    }
    isModalOpen.value = false
    refresh()
  } catch (error) {
    toast.add({ title: 'Error', description: error.message, color: 'red' })
  } finally {
    isSaving.value = false
  }
}

const confirmDelete = async (item) => {
  if (confirm(`Hapus event absensi "${item.name}"? Ini tidak akan menghapus data riwayat absensinya karena foreign key di-set cascade atau tertahan. (Sebaiknya pastikan dulu)`)) {
    try {
      const { error } = await supabase.from('attendance_events').delete().eq('id', item.id)
      if (error) throw error
      toast.add({ title: 'Terhapus', description: 'Event absensi dihapus.', color: 'green' })
      refresh()
    } catch (error) {
      toast.add({ title: 'Error', description: 'Gagal menghapus. Event mungkin sedang digunakan di sesi absensi.', color: 'red' })
    }
  }
}
</script>
