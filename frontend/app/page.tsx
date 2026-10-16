"use client";

import Link from "next/link";
import Image from "next/image";
import {useEffect, useState} from "react";
import {GRADIENTS, STYLES} from "@/lib/theme";

type Task = {
    title: string;
    description: string;
    href: string;
    imgSrc: string;
    imgAlt: string;
};

const TASKS: Task[] = [
    {
        title: "تشخیص بیماری",
        description: "دریافت لیست بیماری‌های احتمالی با کمک هوش مصنوعی، بر اساس علائم، سابقه و یافته‌های بالینی حیوان.",
        href: "/diagnose",
        imgSrc: "/illustrations/vet-doctor.png",
        imgAlt: "دامپزشک در حال معاینه سگ با استتوسکوپ",
    },
    {
        title: "کتابخانه بیماری‌ها",
        description: "مرور پایگاه دانش تخصصی دامپزشکی: علائم، علل، روش‌های تشخیصی و پروتکل‌های درمانی.",
        href: "/diseases",
        imgSrc: "/illustrations/disease-library.png",
        imgAlt: "نمایی از کتابخانه دیجیتال دامپزشکی",
    },
    {
        title: "درباره این پلتفرم",
        description: "این سیستم یک ابزار پشتیبانی از تصمیم‌گیری، کاهش احتمال خطای انسانی و افزایش دسترسی به دانش تخصصی است.",
        href: "/about",
        imgSrc: "/illustrations/about-platform.png",
        imgAlt: "نماد تعادل بین تخصص دامپزشکی و هوش مصنوعی در یک سیستم مسئولانه و کمکی",
    },
];

export default function OnboardingPage() {
    const [isMounted, setIsMounted] = useState(false);

    useEffect(() => {
        setIsMounted(true);
    }, []);

    return (
        <main className="min-h-svh overflow-hidden bg-gradient-to-br from-gray-950 via-black to-gray-900 relative">
            {/* 🔆 نورهای پس‌زمینه — با blur بهینه‌شده */}
            <div className="absolute inset-0 opacity-15">
                <div className="absolute top-1/4 left-1/3 w-80 h-80 bg-blue-500 rounded-full blur-[120px] animate-pulse"></div>
                <div className="absolute bottom-1/4 right-1/4 w-72 h-72 bg-cyan-500 rounded-full blur-[100px] animate-pulse delay-700"></div>
                <div className="absolute top-1/2 right-1/2 w-60 h-60 bg-indigo-600 rounded-full blur-[90px] animate-pulse delay-300"></div>
            </div>

            {/* 🌟 ستاره‌های پویا — با animate-pulse استاندارد (SSR-safe) */}
            <div className="absolute inset-0 pointer-events-none">
                {[...Array(25)].map((_, i) => (
                    <div
                        key={i}
                        className="absolute rounded-full bg-white animate-pulse"
                        style={{
                            top: `${Math.random() * 100}%`,
                            left: `${Math.random() * 100}%`,
                            width: `${Math.random() * 2 + 1}px`,
                            height: `${Math.random() * 2 + 1}px`,
                            opacity: Math.random() * 0.5 + 0.1,
                            animationDuration: `${Math.random() * 4 + 2}s`,
                            animationDelay: `${Math.random() * 2}s`,
                        }}
                    />
                ))}
            </div>

            <section className="relative w-full min-h-screen flex flex-col items-center justify-center mx-auto max-w-6xl gap-5 px-4 sm:px-6 py-10 z-10">
                {/* 🖼️ لوگو — با glow هماهنگ با عدد 404 */}
                <div
                    className={`transition-all duration-700 ease-out ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                    }`}
                >
                    <div className="relative w-40 h-40 md:w-48 md:h-48 mx-auto">
                        <Image
                            src="/logo/Vet_Logo.png"
                            alt="وِت‌اسیست — همراه هوشمند دامپزشکان"
                            fill
                            className="object-contain"
                            priority
                            style={{
                                filter: `
                  drop-shadow(0 4px 20px rgba(59, 130, 246, 0.25))
                  drop-shadow(0 0 16px rgba(59, 130, 246, 0.15))
                `,
                            }}
                        />
                    </div>
                </div>

                <div
                    className={`space-y-3 text-center transition-all duration-700 ease-out delay-150 ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                    }`}
                >
                    <h1
                        className="text-3xl md:text-5xl font-bold leading-tight tracking-tight"
                        style={STYLES.glowText} // ✅ همان glow 404
                    >
                        توانمندسازی مراقبت‌های دامپزشکی
                    </h1>

                    <h2
                        className="text-xl md:text-2xl font-medium"
                        style={{
                            background: GRADIENTS.subtitle,
                            WebkitBackgroundClip: "text",
                            backgroundClip: "text",
                            color: "transparent",
                            textShadow: "0 0 12px rgba(147, 197, 253, 0.2)",
                        }}
                    >
                        با هوش مصنوعی پیشرفته
                    </h2>

                    <p className="text-base text-gray-400 max-w-2xl mt-3">
                        امروز چگونه می‌خواهید از وِت‌اسیست استفاده کنید؟
                    </p>
                </div>

                {/* 📦 کارت‌ها — با انیمیشن‌های هماهنگ */}
                <div
                    className={`grid grid-cols-1 md:grid-cols-3 gap-6 w-full transition-all duration-700 ease-out delay-300 ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-8"
                    }`}
                >
                    {TASKS.map((task, idx) => (
                        <TaskCard task={task} key={task.title} delay={idx * 100} />
                    ))}
                </div>
            </section>
        </main>
    );
}

// ✨ کارت شیشه‌ای — با استایل‌های مرکزی‌شده
function TaskCard({ task, delay = 0 }: { task: Task; delay?: number }) {
    return (
        <Link
            href={task.href}
            aria-label={`رفتن به ${task.title}`}
            className="group block h-full"
            style={{ animationDelay: `${delay}ms` }}
        >
            <div
                className="relative h-full rounded-2xl overflow-hidden border transition-all duration-500 ease-out
                   hover:scale-[1.02] hover:border-blue-500/40 active:scale-[0.98]"
                style={{
                    ...STYLES.glassPanel,
                    boxShadow: `
            0 20px 40px -15px rgba(0, 0, 0, 0.6),
            inset 0 1px 0 rgba(255, 255, 255, 0.05),
            inset 0 -1px 0 rgba(0, 0, 0, 0.3)
          `,
                }}
            >
                {/* لایه گرادیان داخلی — ثابت و بهینه */}
                <div
                    className="absolute inset-0 pointer-events-none opacity-40"
                    style={{
                        background: `
              radial-gradient(circle at 30% 30%, rgba(96, 165, 250, 0.1) 0%, transparent 70%),
              radial-gradient(circle at 80% 70%, rgba(147, 51, 234, 0.07) 0%, transparent 70%)
            `,
                    }}
                />

                <div className="p-6 flex flex-col items-center text-center relative z-10">
                    <div className="relative h-36 w-36 sm:h-44 sm:w-44 mb-5 group-hover:scale-105 transition-transform duration-500">
                        <div className="absolute inset-0 bg-gradient-to-br from-blue-500/10 to-transparent rounded-2xl blur-sm -z-10 opacity-0 group-hover:opacity-100 transition-opacity" />
                        <div className="absolute inset-0 rounded-2xl shadow-lg shadow-blue-500/10 -z-10 group-hover:shadow-xl group-hover:shadow-blue-500/20 transition-shadow" />
                        <Image
                            src={task.imgSrc}
                            alt={task.imgAlt}
                            fill
                            className="object-contain"
                            loading="lazy"
                        />
                    </div>

                    <h3
                        className="text-xl font-semibold text-gray-100 mb-2 group-hover:text-blue-200 transition-colors"
                        style={{
                            textShadow: "0 1px 3px rgba(0,0,0,0.4)",
                        }}
                    >
                        {task.title}
                    </h3>

                    <p className="text-sm text-gray-400 leading-relaxed px-1 mb-4">
                        {task.description}
                    </p>

                    <div className="h-px w-8 bg-gradient-to-r from-transparent via-blue-500/40 to-transparent"></div>
                </div>

                {/* ✨ Glow border — فقط هنگام hover */}
                <div
                    className="absolute inset-0 rounded-2xl pointer-events-none opacity-0 group-hover:opacity-100 transition-opacity duration-500"
                    style={{
                        boxShadow: "0 0 0 2px rgba(96, 165, 250, 0.3), 0 0 20px rgba(96, 165, 250, 0.15)",
                    }}
                />
            </div>
        </Link>
    );
}