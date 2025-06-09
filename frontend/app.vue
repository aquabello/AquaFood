<template>
  <div>
    <h1>Nuxt3 Frontend</h1>
    <button @click="fetchHello" :disabled="loading">
      {{ loading ? 'Loading...' : 'Call Backend' }}
    </button>
    <p v-if="message">Message from backend: {{ message }}</p>
    <p v-if="error" style="color: red;">Error: {{ error }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const message = ref('');
const error = ref('');
const loading = ref(false);

// Use runtime config to get the API base URL
const runtimeConfig = useRuntimeConfig();
// Define a default or ensure it's set in nuxt.config.ts if needed
const apiBaseUrl = runtimeConfig.public.apiBaseUrl || '/api';

async function fetchHello() {
  loading.value = true;
  error.value = '';
  message.value = '';
  try {
    const response = await fetch(`${apiBaseUrl}/hello`);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    message.value = data.message;
  } catch (e) {
    error.value = e.message;
    console.error('Failed to fetch hello:', e);
  } finally {
    loading.value = false;
  }
}
</script>

<style>
body {
  font-family: sans-serif;
  padding: 20px;
}
button {
  margin-bottom: 10px;
  padding: 8px 15px;
  cursor: pointer;
}
</style>
