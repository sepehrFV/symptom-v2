"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

export default function NotFound() {
    const [isMounted, setIsMounted] = useState(false);

    useEffect(() => {
        setIsMounted(true);
    }, []);

    return (
        <div
            className="flex items-center justify-center min-h-screen px-4 bg-gradient-to-br from-gray-900 via-black to-gray-950 overflow-hidden relative"
            style={{
                background: `
          radial-gradient(circle at 30% 30%, rgba(59, 130, 246, 0.08) 0%, transparent 40%),
          radial-gradient(circle at 70% 70%, rgba(147, 51, 234, 0.06) 0%, transparent 50%),
          #000000
        `,
            }}
        >
            {/* نور پراکنده در پس‌زمینه */}
            <div className="absolute inset-0 opacity-20">
                <div className="absolute top-1/4 left-1/4 w-72 h-72 bg-blue-500 rounded-full blur-[120px] animate-pulse"></div>
                <div className="absolute bottom-1/3 right-1/4 w-64 h-64 bg-purple-500 rounded-full blur-[100px] animate-pulse delay-700"></div>
            </div>

            <div
                className={`relative bg-white/5 backdrop-blur-3xl rounded-3xl shadow-2xl border border-white/10 p-8 md:p-10 max-w-md w-full transition-all duration-700 ${
                    isMounted ? "scale-100 opacity-100" : "scale-95 opacity-0"
                }`}
                style={{
                    boxShadow: `
            0 25px 50px -12px rgba(0, 0, 0, 0.5),
            inset 0 1px 0 rgba(255, 255, 255, 0.05),
            inset 0 -1px 0 rgba(0, 0, 0, 0.3)
          `,
                    WebkitBackdropFilter: "blur(64px) saturate(180%)",
                    backdropFilter: "blur(64px) saturate(180%)",
                }}
            >
                {/* گرادیان لبه داخلی برای جلوه شیشه‌ای واقعی */}
                <div
                    className="absolute inset-0 rounded-3xl pointer-events-none opacity-60"
                    style={{
                        background: `
              linear-gradient(135deg,
                rgba(59, 130, 246, 0.15) 0%,
                rgba(147, 51, 234, 0.1) 50%,
                rgba(37, 99, 235, 0.08) 100%
              )
            `,
                        mask: "radial-gradient(circle, white 70%, transparent 100%)",
                    }}
                />

                <div className="relative z-10 text-center">
                    {/* عدد 404 با تابش نئونی */}
                    <h1
                        className="text-7xl md:text-8xl font-bold bg-clip-text text-transparent animate-pulse"
                        style={{
                            background: "linear-gradient(145deg, #60a5fa, #818cf8, #a78bfa)",
                            textShadow: "0 0 20px rgba(96, 165, 250, 0.4)",
                            WebkitBackgroundClip: "text",
                            letterSpacing: "-0.05em",
                        }}
                    >
                        404
                    </h1>

                    <p className="mt-5 text-xl font-semibold text-gray-100 tracking-tight">
                        صفحه‌ای یافت نشد
                    </p>

                    <p className="mt-3 text-gray-400 leading-relaxed px-2">
                        به نظر می‌رسد آدرس مورد نظر اشتباه است یا محتوا حذف شده است.
                    </p>

                    <div className="mt-8">
                        <Link
                            href="/"
                            className="inline-flex items-center justify-center px-6 py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white font-medium rounded-xl shadow-lg hover:from-blue-400 hover:to-blue-500 active:scale-95 transition-all duration-300 transform shadow-blue-500/20 hover:shadow-blue-400/40"
                        >
                            <span>بازگشت به خانه</span>
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                className="mr-2 h-4 w-4"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                            </svg>
                        </Link>
                    </div>

                    {/* جزئیات زیبا: خط نازک زیر دکمه */}
                    <div className="mt-6">
                        <div className="h-px bg-gradient-to-r from-transparent via-blue-500/30 to-transparent w-16 mx-auto"></div>
                    </div>
                </div>
            </div>

            {/* ستاره‌های پویا در پس‌زمینه (اختیاری — برای جلوه بیشتر) */}
            <div className="absolute inset-0 pointer-events-none">
                {[...Array(20)].map((_, i) => (
                    <div
                        key={i}
                        className="absolute rounded-full bg-white animate-pulse"
                        style={{
                            top: `${Math.random() * 100}%`,
                            left: `${Math.random() * 100}%`,
                            width: `${Math.random() * 3 + 1}px`,
                            height: `${Math.random() * 3 + 1}px`,
                            opacity: Math.random() * 0.6 + 0.2,
                            animationDuration: `${Math.random() * 4 + 2}s`,
                            animationDelay: `${Math.random() * 2}s`,
                        }}
                    />
                ))}
            </div>
        </div>
    );
}