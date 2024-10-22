# Menggunakan image Node.js sebagai base
FROM node:20

# Set working directory
WORKDIR /app

# Menyalin package.json dan package-lock.json
COPY package*.json ./

# Menginstal dependencies
RUN npm install

# Menyalin semua file aplikasi
COPY . .

# Membangun aplikasi untuk produksi
RUN npm run build

# Menggunakan Nginx untuk menyajikan aplikasi
FROM nginx:alpine

# Menyalin hasil build dari tahap sebelumnya
COPY --from=0 /app/build /usr/share/nginx/html

# Mengekspos port yang digunakan Nginx
EXPOSE 80

# Perintah untuk menjalankan Nginx
CMD ["nginx", "-g", "daemon off;"]