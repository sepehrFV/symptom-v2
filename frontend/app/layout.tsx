// app/layout.tsx
"use client";
import "./globals.css";
import {Toaster} from "react-hot-toast";
import ProgressProvider from '@/components/progressProvider';
import {BreadcrumbProvider} from "@/context/BreadcrumbContext"; // ✅ Import it
import localFont from "next/font/local";
import {Poppins} from "next/font/google";

import "@fontsource/vazirmatn/latin-400.css";
import "@fontsource/vazirmatn/latin-500.css";
import "@fontsource/vazirmatn/latin-700.css";

const Switzer = localFont({
    src: "../public/fonts/Switzer-Variable.woff2",
    variable: "--font-switzer",
    fallback: ['helvetica','arial','system-ui', 'sans-serif'],
});

const poppins = Poppins({
    weight: ['100', '200', '300', '400', '500', '600', '700', '800', '900'],
    style: ['normal', 'italic'],
    subsets: ['latin'],
    display: 'swap',
    variable: "--font-poppins",
    fallback: ['arial','system-ui', 'sans-serif'],
});

export default function RootLayout({
                                       children,
                                   }: {
    children: React.ReactNode;
}) {
    return (
        <html lang="en" dir="rtl">
        <body className={`${Switzer.variable} ${poppins.variable} antialiased`}>
        {/* ✅ Add BreadcrumbProvider here — order doesn’t matter much */}
            <ProgressProvider>
                <BreadcrumbProvider>
                    <Toaster position="top-left" toastOptions={{duration: 4000}}/>
                    {children}
                </BreadcrumbProvider>
            </ProgressProvider>
        </body>
        </html>
    );
}