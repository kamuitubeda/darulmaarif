<template>
  <div class="pb-6 relative min-h-screen flex flex-col">
    <!-- Header -->
    <div class="flex items-center gap-2 mb-6 -mx-4 px-4 pb-4 border-b border-gray-100 bg-white pt-4">
      <UButton icon="i-heroicons-arrow-left" color="gray" variant="ghost" to="/psb" v-if="currentStep === 1" />
      <UButton icon="i-heroicons-arrow-left" color="gray" variant="ghost" @click="prevStep" v-else />
      <div>
         <h2 class="text-xl font-bold text-gray-800 tracking-tight leading-tight">Formulir PSB</h2>
         <p class="text-[10px] text-green-600 font-bold uppercase tracking-widest mt-0.5">Langkah {{ currentStep }} dari 4</p>
      </div>
    </div>

    <!-- Progress steps visual -->
    <div class="mb-8 px-2 flex justify-between items-center relative">
       <div class="absolute top-1/2 left-0 right-0 h-1 bg-gray-200 -z-10 -translate-y-1/2 rounded-full overflow-hidden">
          <div class="h-full bg-green-500 transition-all duration-500 ease-out" :style="{ width: `${(currentStep - 1) * 33.33}%` }"></div>
       </div>
       <div v-for="step in 4" :key="step" class="w-8 h-8 rounded-full flex items-center justify-center font-bold text-xs ring-4 ring-white shadow-sm transition-colors duration-500" :class="currentStep >= step ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-500'">
          <UIcon v-if="currentStep > step" name="i-heroicons-check" class="w-4 h-4" />
          <span v-else>{{ step }}</span>
       </div>
    </div>

    <!-- Forms -->
    <div class="bg-white p-5 rounded-3xl shadow-sm border border-gray-100 relative">
      <form @submit.prevent="handleNextOrSubmit">
        
        <!-- Step 1: Santri -->
        <div v-if="currentStep === 1" class="space-y-4 animate-in slide-in-from-right-4 fade-in duration-300">
           <div class="mb-4">
              <h3 class="font-extrabold text-gray-800 text-lg">Data Santri</h3>
              <p class="text-xs text-gray-500">Lengkapi identitas calon santri secara valid.</p>
           </div>
           <UFormGroup label="Nama Lengkap" name="student_name" required>
             <UInput v-model="formState.student_name" placeholder="Sesuai Akta Kelahiran" required />
           </UFormGroup>
           <UFormGroup label="Tempat Lahir" name="birth_place" required>
             <UInput v-model="formState.birth_place" placeholder="Kota lahir" required />
           </UFormGroup>
           <UFormGroup label="Tanggal Lahir" name="birth_date" required>
             <UInput v-model="formState.birth_date" type="date" required />
           </UFormGroup>
           <UFormGroup label="Alamat Tempat Tinggal" name="address" required>
             <UTextarea v-model="formState.address" placeholder="Tuliskan alamat domisili saat ini" autoresize required />
           </UFormGroup>
        </div>

        <!-- Step 2: Orang Tua -->
        <div v-if="currentStep === 2" class="space-y-4 animate-in slide-in-from-right-4 fade-in duration-300">
           <div class="mb-4">
              <h3 class="font-extrabold text-gray-800 text-lg">Data Orang Tua / Wali</h3>
              <p class="text-xs text-gray-500">Informasi ini akan kami gunakan untuk kontak darurat.</p>
           </div>
           <UFormGroup label="Nama Ayah Kandung" name="father_name" required>
             <UInput v-model="formState.father_name" placeholder="Sesuai Kartu Keluarga" required />
           </UFormGroup>
           <UFormGroup label="Nama Ibu Kandung" name="mother_name" required>
             <UInput v-model="formState.mother_name" placeholder="Sesuai Kartu Keluarga" required />
           </UFormGroup>
           <UFormGroup label="Nomor WhatsApp" name="guardian_phone" required>
             <UInput v-model="formState.guardian_phone" type="tel" placeholder="Contoh: 081234..." icon="i-heroicons-device-phone-mobile" required />
           </UFormGroup>
        </div>

        <!-- Step 3: Uploads -->
        <div v-if="currentStep === 3" class="space-y-4 animate-in slide-in-from-right-4 fade-in duration-300">
           <div class="mb-4">
              <h3 class="font-extrabold text-gray-800 text-lg">Unggah Dokumen</h3>
              <p class="text-xs text-gray-500">Mohon unggah dokumen dalam format Jpg/Png/Pdf proporsional.</p>
           </div>
           <UFormGroup label="Kartu Keluarga (KK)" name="family_card" required help="Gunakan scanner / potret jelas terbaca">
             <UInput type="file" v-model="files.family_card" accept="image/*,application/pdf" icon="i-heroicons-document" required />
           </UFormGroup>
           <UFormGroup label="Akta Kelahiran" name="birth_certificate" required>
             <UInput type="file" v-model="files.birth_certificate" accept="image/*,application/pdf" icon="i-heroicons-document-text" required />
           </UFormGroup>
           <UFormGroup label="Pas Foto Santri (3x4 Latar Merah)" name="student_photo" required>
             <UInput type="file" v-model="files.student_photo" accept="image/*" icon="i-heroicons-photo" required />
           </UFormGroup>
        </div>

        <!-- Step 4: Konfirmasi -->
        <div v-if="currentStep === 4" class="space-y-4 animate-in slide-in-from-right-4 fade-in duration-300">
           <div class="mb-4">
              <h3 class="font-extrabold text-gray-800 text-lg">Konfirmasi Akhir</h3>
              <p class="text-xs text-gray-500">Periksa kembali data diri yang akan dikirimkan.</p>
           </div>
           
           <div class="bg-gray-50 p-4 rounded-2xl border border-gray-100 text-sm space-y-3">
             <div class="grid grid-cols-3 gap-2 border-b border-gray-200 pb-2">
               <span class="text-gray-500 col-span-1 text-xs">Nama Santri:</span>
               <span class="font-semibold text-gray-800 col-span-2">{{ formState.student_name }}</span>
             </div>
             <div class="grid grid-cols-3 gap-2 border-b border-gray-200 pb-2">
               <span class="text-gray-500 col-span-1 text-xs">TTL:</span>
               <span class="font-semibold text-gray-800 col-span-2">{{ formState.birth_place }}, {{ formState.birth_date }}</span>
             </div>
             <div class="grid grid-cols-3 gap-2 border-b border-gray-200 pb-2">
               <span class="text-gray-500 col-span-1 text-xs">Orang Tua:</span>
               <span class="font-semibold text-gray-800 col-span-2">{{ formState.father_name }} & {{ formState.mother_name }}</span>
             </div>
             <div class="grid grid-cols-3 gap-2">
               <span class="text-gray-500 col-span-1 text-xs">WhatsApp:</span>
               <span class="font-semibold text-gray-800 col-span-2">{{ formState.guardian_phone }}</span>
             </div>
           </div>

           <div class="bg-green-50 p-4 rounded-xl border border-green-200 flex gap-3 text-xs text-green-800">
             <UIcon name="i-heroicons-information-circle" class="w-5 h-5 shrink-0" />
             <p>Data dan berkas otomatis tersimpan di Cloud Database Supabase saat Anda mengklik submit.</p>
           </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-8 pt-4 border-t border-gray-100">
          <UButton
            v-if="currentStep < 4"
            type="submit"
            block
            color="green"
            size="xl"
            class="rounded-2xl shadow-sm font-bold text-base tracking-wide"
            trailing-icon="i-heroicons-arrow-right"
          >
            Lanjutkan
          </UButton>
          
          <UButton
            v-if="currentStep === 4"
            type="button"
            :loading="isSubmitting"
            @click="submitFormToSupabase"
            block
            color="green"
            size="xl"
            class="rounded-2xl shadow-md font-bold text-base tracking-wide"
            trailing-icon="i-heroicons-cloud-arrow-up"
          >
            Finalisasi Pendaftaran
          </UButton>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

definePageMeta({ title: 'Pendaftaran PSB - Darul Maarif' })

const supabase = useSupabaseClient()

const currentStep = ref(1)
const isSubmitting = ref(false)

const formState = reactive({
  student_name: '',
  birth_place: '',
  birth_date: '',
  address: '',
  father_name: '',
  mother_name: '',
  guardian_phone: ''
})

const files = reactive({
  family_card: null,
  birth_certificate: null,
  student_photo: null
})

const nextStep = () => { if (currentStep.value < 4) currentStep.value++ }
const prevStep = () => { if (currentStep.value > 1) currentStep.value-- }
const handleNextOrSubmit = () => {
    // Basic native HTML validation is triggered via form @submit
    if (currentStep.value < 4) return nextStep()
}

// Supabase Logic Execution
const submitFormToSupabase = async () => {
  isSubmitting.value = true
  try {
    const uploadSingleFile = async (fileList, prefix) => {
      if (!fileList || fileList.length === 0) return null
      const rawFile = fileList[0] // Because UInput type="file" binds a FileList locally
      const ext = rawFile.name.split('.').pop()
      const fileName = `${prefix}_${Date.now()}.${ext}`
      
      const { data, error } = await supabase.storage.from('psb_documents').upload(fileName, rawFile)
      if (error) throw error
      return data.path
    }

    // 1. Upload files sequentially
    const familyCardPath = await uploadSingleFile(files.family_card, 'kk')
    const birthCertPath = await uploadSingleFile(files.birth_certificate, 'akta')
    const photoPath = await uploadSingleFile(files.student_photo, 'photo')

    // 2. Insert into database
    const payload = {
      ...formState,
      family_card: familyCardPath,
      birth_certificate: birthCertPath,
      student_photo: photoPath,
      status: 'submitted'
    }

    const { error: dbError } = await supabase.from('psb_applications').insert(payload)
    if (dbError) throw dbError

    // 3. Complete and Route
    navigateTo('/psb/status')

  } catch(e) {
    console.error('Submission error:', e)
    alert(`Terjadi kesalahan operasi Supabase: ${e.message}\nPastikan .env sudah dikonfigurasi.`)
  } finally {
    isSubmitting.value = false
  }
}
</script>
