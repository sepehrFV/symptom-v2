import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/** @type {import('next').NextConfig} */
const nextConfig = {
  webpack: (config) => {
    config.resolve.alias["@shared"] = path.resolve(__dirname, "../shared");
    return config;
  },
  images: {
    unoptimized: true,
    domains: ["pixabay.com"],
    remotePatterns: [
      {
        protocol: "https",
        hostname: "pixabay.com",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "symptom-service.onrender.com",
        pathname: "/serve/**",
      },
      {
        protocol: "https",
        hostname: "symptom-service.onrender.com",
        pathname: "/public/**",
      },
    ],
  },
};

export default nextConfig;