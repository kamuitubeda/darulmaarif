<template>
  <div>
    <AdminPageHeader 
      :title="`Data Santri ${levelText}`" 
      :description="`Kelola daftar siswa/santri tingkat ${levelText}.`"
      icon="i-heroicons-user-group"
    >
      <template #actions>
        <UButton color="green" icon="i-heroicons-plus" @click="openModal()">
          Tambah Santri
        </UButton>
      </template>
    </AdminPageHeader>

    <UCard>
      <div class="flex items-center gap-4 mb-4">
        <UInput v-model="searchQuery" icon="i-heroicons-magnifying-glass" placeholder="Cari NIS atau Nama..." class="w-64" />
        <USelectMenu v-model="classFilter" :options="availableClasses" placeholder="Semua Kelas" clearable class="w-40" />
      </div>

      <UTable :columns="columns" :rows="filteredStudents" :loading="pending">
        <template #status-data="{ row }">
          <UBadge :color="row.is_active ? 'green' : 'gray'" variant="soft">
            {{ row.is_active ? 'Aktif' : 'Non-Aktif' }}
          </UBadge>
        </template>
        <template #gender-data="{ row }">
          {{ row.gender === 'L' ? 'Laki-laki' : 'Perempuan' }}
        </template>
        <template #dormitory-data="{ row }">
          <span v-if="row.dormitory" class="text-gray-700">{{ row.dormitory }}</span>
          <span v-else class="text-gray-400 italic text-xs">Reguler</span>
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
              {{ editingId ? 'Edit Santri' : 'Tambah Santri' }}
            </h3>
            <UButton color="gray" variant="ghost" icon="i-heroicons-x-mark-20-solid" class="-my-1" @click="isModalOpen = false" />
          </div>
        </template>
        
        <form @submit.prevent="saveStudent" class="space-y-4">
          <UFormGroup label="NIS" required>
            <UInput v-model="form.nis" placeholder="Nomor Induk Santri/Siswa" required />
          </UFormGroup>
          <UFormGroup label="Nama Lengkap" required>
            <UInput v-model="form.name" placeholder="Nama Santri" required />
          </UFormGroup>
          <div class="grid grid-cols-2 gap-4">
            <UFormGroup label="Jenis Kelamin" required>
              <USelect v-model="form.gender" :options="[{label:'Laki-laki', value:'L'}, {label:'Perempuan', value:'P'}]" required />
            </UFormGroup>
            <UFormGroup label="Kelas" required>
              <UInput v-model="form.class_name" placeholder="Misal: VII-A" required />
            </UFormGroup>
          </div>
          <UFormGroup label="Asrama / Kamar">
            <UInput v-model="form.dormitory" placeholder="Opsional (kosongkan jika reguler)" />
          </UFormGroup>
          <UFormGroup label="Status">
            <UToggle v-model="form.is_active" />
            <span class="text-sm ml-2 text-gray-600">{{ form.is_active ? 'Santri Aktif' : 'Non-Aktif/Alumni' }}</span>
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
import { ref, computed } from 'vue'

const route = useRoute()
const supabase = useSupabaseClient()
const toast = useToast()

const levelText = computed(() => (route.params.level || '').toUpperCase())

useHead({
  title: `Data Santri ${levelText.value} - Admin Darul Maarif`
})

const columns = [
  { key: 'nis', label: 'NIS', sortable: true },
  { key: 'name', label: 'Nama Lengkap', sortable: true },
  { key: 'gender', label: 'L/P' },
  { key: 'class_name', label: 'Kelas', sortable: true },
  { key: 'dormitory', label: 'Asrama' },
  { key: 'status', label: 'Status' },
  { key: 'actions', label: 'Aksi' }
]

const { data: students, pending, refresh } = useAsyncData(`students-${levelText.value}`, () =>
  supabase.from('students')
    .select('*')
    .eq('level', levelText.value)
    .order('class_name', { ascending: true })
    .order('name', { ascending: true })
    .then(r => r.data ?? [])
)

// Filtering
const searchQuery = ref('')
const classFilter = ref(null)

const availableClasses = computed(() => {
  if (!students.value) return []
  const classes = new Set(students.value.map(s => s.class_name))
  return Array.from(classes).sort()
})

const filteredStudents = computed(() => {
  if (!students.value) return []
  let res = students.value
  
  if (searchQuery.value) {
    const q = searchQuery.value.toLowerCase()
    res = res.filter(s => s.name.toLowerCase().includes(q) || s.nis.toLowerCase().includes(q))
  }
  
  if (classFilter.value) {
    res = res.filter(s => s.class_name === classFilter.value)
  }
  
  return res
})

// Modal & Form State
const isModalOpen = ref(false)
const isSaving = ref(false)
const editingId = ref(null)
const form = ref({
  nis: '',
  name: '',
  gender: 'L',
  class_name: '',
  dormitory: '',
  is_active: true
})

const openModal = (item = null) => {
  if (item) {
    editingId.value = item.id
    form.value = { ...item }
  } else {
    editingId.value = null
    form.value = {
      nis: '',
      name: '',
      gender: 'L',
      class_name: '',
      dormitory: '',
      is_active: true
    }
  }
  isModalOpen.value = true
}

const saveStudent = async () => {
  isSaving.value = true
  try {
    const payload = {
      ...form.value,
      level: levelText.value,
      dormitory: form.value.dormitory || null
    }
    
    if (editingId.value) {
      const { error } = await supabase.from('students').update(payload).eq('id', editingId.value)
      if (error) throw error
      toast.add({ title: 'Berhasil', description: 'Data santri diperbarui.', color: 'green' })
    } else {
      const { error } = await supabase.from('students').insert(payload)
      if (error) throw error
      toast.add({ title: 'Berhasil', description: 'Santri baru ditambahkan.', color: 'green' })
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
  if (confirm(`Hapus data santri ${item.name}?`)) {
    try {
      const { error } = await supabase.from('students').delete().eq('id', item.id)
      if (error) throw error
      toast.add({ title: 'Terhapus', description: 'Data santri dihapus.', color: 'green' })
      refresh()
    } catch (error) {
      toast.add({ title: 'Error', description: error.message, color: 'red' })
    }
  }
}
</script>
