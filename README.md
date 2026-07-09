# Cloud-Dokumentasi-

# Automated Self-Hosted Media Server Architecture (Fufufafa Project)

Repository ini berisi dokumentasi, berkas konfigurasi, dan script otomatisasi untuk membangun **Private Media Streaming Server** mandiri menggunakan **Jellyfin** berbasis OS **Ubuntu Server 24.04 LTS**, dengan memanfaatkan penyimpanan berbasis Cloud (**Google Drive**) via **Rclone Engine**.

## Fitur Utama
- **Cloud-Storage Mounting:** Menghubungkan penyimpanan Google Drive secara dinamis tanpa memakan kapasitas *harddisk* lokal (Local Disk Saving).
- **VFS Stream Optimization:** Menggunakan teknik *chunki-reading buffering* (32M/2G) untuk mencegah terjadinya *Playback Error* atau *Stuck* pada pemutaran video beresolusi tinggi (1080p/2160p).
- **Auto-Maintenance Script:** Pembersihan otomatis log systemd dan berkas *cache transient* secara berkala untuk menjaga stabilitas kapasitas penyimpanan root server di atas ambang batas kritis (Required: 2GB).
- **DNS Hijack Bypass:** Menggunakan DNS independen (Cloudflare `1.1.1.1` & Google `8.8.8.8`) untuk menghindari kegagalan *resolving* metadata scraper akibat restriksi ISP lokal.

---

##  Komponen Infrastruktur IT
- **OS Server:** Ubuntu Server 24.04 LTS
- **Client Deployment Device:** Kali Linux Desktop Environment
- **Core Media Service:** Jellyfin Media Server v10.11.x
- **Storage Bridge:** Rclone v1.6x (Virtual File System Mode)
- **Downloader Engine:** Aria2 Download Utility & Wget

---

##  Struktur Direktori Project
```text
├── setup-gdrive.sh      # Script bash otomatisasi mounting & pembersihan cache
├── jellyfin.service     # Contoh berkas konfigurasi Systemd Service Linux
└── README.md            # Dokumentasi utama proyek
