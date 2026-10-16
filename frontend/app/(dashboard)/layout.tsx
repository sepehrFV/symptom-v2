// app/(dashboard)/layout.tsx
"use client";

import {Button} from "@shared/components/ui/button";
import Link from "next/link";
import {Home} from "lucide-react";
import Image from "next/image";
import {GRADIENTS} from "@/lib/theme";

export default function DashboardLayout({
                                            children,
                                        }: {
    children: React.ReactNode;
}) {
    return (
        <>
            {/* ✨ نوار بالایی — برای احساس عمق و جهت‌یابی در اسکرول */}
            <div
                className="fixed top-0 left-0 right-0 h-12 z-40 pointer-events-none"
                style={{
                    background: `
            linear-gradient(
              to bottom,
              rgba(0, 0, 0, 0.6) 0%,
              rgba(0, 0, 0, 0.2) 70%,
              transparent 100%
            )
          `,
                    WebkitBackdropFilter: "blur(12px)",
                    backdropFilter: "blur(12px)",
                }}
            />

            {/* 🔙 دکمه Home — در گوشه بالا-چپ */}
            <div className="fixed top-4 right-4 z-50">
                <Button
                    asChild
                    variant="ghost"
                    size="sm"
                    className="relative gap-1.5 overflow-hidden rounded-xl border border-white/10
                     bg-white/5 backdrop-blur-xl
                     hover:bg-white/10 hover:border-blue-500/40
                     active:scale-95 transition-all duration-300
                     shadow-lg hover:shadow-blue-500/10"
                    style={{
                        WebkitBackdropFilter: "blur(12px) saturate(150%)",
                        backdropFilter: "blur(12px) saturate(150%)",
                    }}
                >
                    <Link href="/">
                        <Home className="h-4 w-4 text-gray-200 group-hover:text-blue-300 transition-colors" />
                        <span className="text-gray-200 group-hover:text-blue-200 font-medium">خانه</span>
                        {/* لایهٔ گرادیان داخلی برای جلوهٔ شیشه */}
                        <div
                            className="absolute inset-0 pointer-events-none opacity-30"
                            style={{
                                background: `radial-gradient(circle at 20% 30%, rgba(96, 165, 250, 0.1) 0%, transparent 80%)`,
                            }}
                        />
                    </Link>
                </Button>
            </div>

            {/* 🖼️ لوگو — در گوشه بالا-راست (مقابل دکمه خانه) */}
            <div className="fixed top-4 left-4 z-50">
                <div className="relative w-40 h-8">
                    <Image
                        src="/logo/Vet_Logo.png"
                        alt="وِت‌اسیست — همراه هوشمند دامپزشکان"
                        fill
                        className="object-contain"
                        priority
                        style={{
                            filter: `
                drop-shadow(0 2px 10px rgba(59, 130, 246, 0.2))
                drop-shadow(0 0 12px rgba(59, 130, 246, 0.1))
              `,
                        }}
                    />
                </div>
            </div>

            {/* 📄 محتوای اصلی — با padding مناسب */}
            <div
                className="min-h-screen pt-16 px-4 pb-8 relative"
                style={{
                    background: `
            ${GRADIENTS.glowBlue},
            ${GRADIENTS.glowPurple},
            #000000
          `,
                }}
            >
                {/* ستاره‌های ریز — فقط برای عمق بصری */}
                <div className="absolute inset-0 pointer-events-none opacity-10">
                    {[...Array(12)].map((_, i) => (
                        <div
                            key={i}
                            className="absolute rounded-full bg-white animate-pulse"
                            style={{
                                top: `${Math.random() * 100}%`,
                                left: `${Math.random() * 100}%`,
                                width: `${Math.random() * 1.5 + 0.5}px`,
                                height: `${Math.random() * 1.5 + 0.5}px`,
                                animationDuration: `${Math.random() * 6 + 3}s`,
                            }}
                        />
                    ))}
                </div>

                <div className="max-w-7xl mx-auto">
                    {children}
                </div>
            </div>

            {/* CSS برای glow border در hover دکمه خانه */}
            <style jsx global>{`
        .group:hover::after {
          content: '';
          position: absolute;
          inset: 0;
          border-radius: 0.75rem;
          box-shadow: 0 0 0 2px rgba(96, 165, 250, 0.4), 0 0 12px rgba(96, 165, 250, 0.2);
        }
      `}</style>
        </>
    );
}