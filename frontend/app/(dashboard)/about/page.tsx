// app/about/page.tsx
"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { CheckCircle, XCircle, Lightbulb, AlertTriangle, ShieldCheck } from "lucide-react";
import { GRADIENTS, COLORS, STYLES } from "@/lib/theme";

export default function AboutPage() {
    const [isMounted, setIsMounted] = useState(false);

    useEffect(() => {
        setIsMounted(true);
    }, []);

    return (
        <div
            className="min-h-screen relative overflow-hidden"
            style={{
                background: `
          radial-gradient(circle at 20% 30%, rgba(59, 130, 246, 0.03) 0%, transparent 50%),
          radial-gradient(circle at 80% 70%, rgba(147, 51, 234, 0.02) 0%, transparent 60%),
          #000000
        `,
            }}
        >
            {/* Background elements */}
            <div className="absolute top-1/4 left-1/4 w-80 h-80 bg-blue-500 rounded-full blur-[120px] opacity-10 animate-pulse"></div>
            <div className="absolute bottom-1/3 right-1/3 w-72 h-72 bg-indigo-600 rounded-full blur-[100px] opacity-5 animate-pulse delay-700"></div>

            <div className="max-w-6xl mx-auto px-4 py-12">
                {/* Header */}
                <div className={`text-center mb-16 transition-all duration-1000 ${isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-10"}`}>
                    <h1
                        className="text-4xl md:text-5xl font-bold mb-6"
                        style={STYLES.glowText}
                    >
                        هوش مصنوعی در دامپزشکی
                    </h1>
                    <p className="text-xl text-gray-300 max-w-3xl mx-auto">
                        راهنمای استفادهٔ مسئولانه و حرفه‌ای از دستیارهای هوش مصنوعی در مراقبت‌های دامپزشکی
                    </p>
                </div>

                {/* Introduction */}
                <div
                    className={`mb-16 p-8 rounded-2xl border transition-all duration-1000 delay-300 ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                    }`}
                    style={{
                        ...STYLES.glassPanel,
                        border: `1px solid ${COLORS.glassBorder}`,
                        boxShadow: "0 25px 50px -12px rgba(0, 0, 0, 0.5)"
                    }}
                >
                    <div className="flex items-start gap-4">
                        <Lightbulb className="h-8 w-8 text-blue-400 mt-1 flex-shrink-0" />
                        <div>
                            <h2 className="text-2xl font-bold text-gray-100 mb-3">چشم‌انداز و مأموریت ما</h2>
                            <p className="text-gray-300 leading-relaxed">
                                وِت‌اسیست به عنوان یک <span className="text-blue-300 font-medium">همراه هوشمند</span> طراحی شده تا
                                دانش تخصصی دامپزشکی را در دسترس شما قرار دهد، نه جایگزین تصمیم‌گیری بالینی شما شود.
                                ما بر این باوریم که هوش مصنوعی باید به عنوان یک <span className="text-blue-300 font-medium">ابزار تکمیلی</span> در کنار
                                تجربه و دانش دامپزشک عمل کند.
                            </p>
                        </div>
                    </div>
                </div>

                {/* Do's and Don'ts Section */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
                    {/* ✅ باید‌ها */}
                    <div
                        className={`rounded-2xl overflow-hidden border transition-all duration-1000 delay-500 ${
                            isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                        }`}
                        style={{
                            ...STYLES.glassPanel,
                            border: `1px solid rgba(34, 197, 94, 0.3)`,
                            boxShadow: "0 20px 40px -15px rgba(0, 0, 0, 0.6)"
                        }}
                    >
                        <div className="p-1" style={{ background: "linear-gradient(90deg, rgba(34, 197, 94, 0.2), transparent)" }}>
                            <div className="p-6">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-full bg-green-500/20 flex items-center justify-center">
                                        <CheckCircle className="h-5 w-5 text-green-400" />
                                    </div>
                                    <h2 className="text-2xl font-bold text-gray-100">استفاده‌های مناسب</h2>
                                </div>

                                <div className="space-y-5">
                                    {[
                                        {
                                            title: "مرور سریع دانش تخصصی",
                                            desc: "دسترسی سریع به اطلاعات بیماری‌ها، پروتکل‌های تشخیصی و راهنمای درمان"
                                        },
                                        {
                                            title: "پشتیبانی در فرآیند تشخیص",
                                            desc: "کمک به سازماندهی علائم و پیشنهاد بیماری‌های احتمالی بر اساس الگوهای بالینی"
                                        },
                                        {
                                            title: "آموزش و به‌روزرسانی دانش",
                                            desc: "دسترسی به آخرین یافته‌های تحقیقاتی و پروتکل‌های درمانی استاندارد"
                                        },
                                        {
                                            title: "مستندسازی بالینی",
                                            desc: "کمک به تهیه گزارش‌های ساختاریافته و کامل برای پرونده‌های بیمار"
                                        },
                                        {
                                            title: "مشاوره با مالکان",
                                            desc: "تولید توضیحات ساده‌شده برای کمک به درک مالکان از وضعیت حیوان"
                                        }
                                    ].map((item, idx) => (
                                        <div key={idx} className="flex gap-3">
                                            <CheckCircle className="h-5 w-5 text-green-400 mt-0.5 flex-shrink-0" />
                                            <div>
                                                <h3 className="font-medium text-gray-100">{item.title}</h3>
                                                <p className="text-gray-400 text-sm mt-1">{item.desc}</p>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* ❌ نباید‌ها */}
                    <div
                        className={`rounded-2xl overflow-hidden border transition-all duration-1000 delay-700 ${
                            isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                        }`}
                        style={{
                            ...STYLES.glassPanel,
                            border: `1px solid rgba(239, 68, 68, 0.3)`,
                            boxShadow: "0 20px 40px -15px rgba(0, 0, 0, 0.6)"
                        }}
                    >
                        <div className="p-1" style={{ background: "linear-gradient(90deg, rgba(239, 68, 68, 0.2), transparent)" }}>
                            <div className="p-6">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-full bg-red-500/20 flex items-center justify-center">
                                        <XCircle className="h-5 w-5 text-red-400" />
                                    </div>
                                    <h2 className="text-2xl font-bold text-gray-100">استفاده‌های نامناسب</h2>
                                </div>

                                <div className="space-y-5">
                                    {[
                                        {
                                            title: "جایگزینی تصمیم‌گیری بالینی",
                                            desc: "اعتماد کامل به پیشنهادات سیستم بدون ارزیابی حرفه‌ای و معاینه فیزیکی"
                                        },
                                        {
                                            title: "تشخیص نهایی بدون تأیید",
                                            desc: "ارائه تشخیص قطعی به مالکان بدون تأیید با آزمایش‌ها و یافته‌های بالینی"
                                        },
                                        {
                                            title: "نسخه‌نویسی خودکار",
                                            desc: "تجویز دارو یا درمان بدون بررسی دقیق علائم و سابقه بیمار"
                                        },
                                        {
                                            title: "نادیده گرفتن زمینه بالینی",
                                            desc: "استفاده از سیستم بدون در نظر گرفتن شرایط خاص بیمار، گونه و سابقه"
                                        },
                                        {
                                            title: "اعتماد به اطلاعات ناقص",
                                            desc: "ورود اطلاعات ناقص یا نادرست و انتظار نتایج معتبر"
                                        }
                                    ].map((item, idx) => (
                                        <div key={idx} className="flex gap-3">
                                            <XCircle className="h-5 w-5 text-red-400 mt-0.5 flex-shrink-0" />
                                            <div>
                                                <h3 className="font-medium text-gray-100">{item.title}</h3>
                                                <p className="text-gray-400 text-sm mt-1">{item.desc}</p>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Ethical Guidelines */}
                <div
                    className={`rounded-2xl overflow-hidden border mb-16 transition-all duration-1000 delay-900 ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                    }`}
                    style={{
                        ...STYLES.glassPanel,
                        border: `1px solid ${COLORS.glassBorder}`,
                        boxShadow: "0 20px 40px -15px rgba(0, 0, 0, 0.6)"
                    }}
                >
                    <div className="p-1" style={{ background: "linear-gradient(90deg, rgba(147, 51, 234, 0.2), transparent)" }}>
                        <div className="p-6">
                            <div className="flex items-center gap-3 mb-6">
                                <ShieldCheck className="h-8 w-8 text-purple-400" />
                                <h2 className="text-2xl font-bold text-gray-100">اصول اخلاقی استفاده از هوش مصنوعی</h2>
                            </div>

                            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div className="space-y-4">
                                    <h3 className="font-bold text-gray-200 flex items-center gap-2">
                                        <AlertTriangle className="h-5 w-5 text-amber-400" />
                                        مسئولیت نهایی
                                    </h3>
                                    <p className="text-gray-300">
                                        دامپزشک مسئولیت نهایی هر تصمیم بالینی را بر عهده دارد.
                                        هوش مصنوعی یک ابزار کمکی است، نه جایگزین حکم حرفه‌ای شما.
                                    </p>
                                </div>

                                <div className="space-y-4">
                                    <h3 className="font-bold text-gray-200 flex items-center gap-2">
                                        <Lightbulb className="h-5 w-5 text-blue-400" />
                                        استفاده آگاهانه
                                    </h3>
                                    <p className="text-gray-300">
                                        همیشه مبنای پیشنهادات سیستم را بررسی کنید.
                                        درک محدودیت‌ها و توانمندی‌های فناوری برای استفادهٔ مؤثر ضروری است.
                                    </p>
                                </div>

                                <div className="space-y-4">
                                    <h3 className="font-bold text-gray-200 flex items-center gap-2">
                                        <ShieldCheck className="h-5 w-5 text-green-400" />
                                        امنیت داده‌ها
                                    </h3>
                                    <p className="text-gray-300">
                                        اطلاعات بیماران باید با بالاترین استانداردهای امنیتی محافظت شوند.
                                        سیستم‌های هوش مصنوعی نباید حریم خصوصی مالکان و بیماران را نقض کنند.
                                    </p>
                                </div>

                                <div className="space-y-4">
                                    <h3 className="font-bold text-gray-200 flex items-center gap-2">
                                        <AlertTriangle className="h-5 w-5 text-purple-400" />
                                        شفافیت
                                    </h3>
                                    <p className="text-gray-300">
                                        به مالکان توضیح دهید که از ابزارهای هوش مصنوعی برای
                                        پشتیبانی از تصمیم‌گیری استفاده می‌کنید، نه جایگزینی آن.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Call to Action */}
                <div
                    className={`text-center p-8 rounded-2xl border transition-all duration-1000 delay-1000 ${
                        isMounted ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
                    }`}
                    style={{
                        ...STYLES.glassPanel,
                        border: `1px solid ${COLORS.glassBorder}`,
                        boxShadow: "0 25px 50px -12px rgba(0, 0, 0, 0.5)"
                    }}
                >
                    <h2 className="text-2xl font-bold text-gray-100 mb-4">
                        همراهی هوشمند، تصمیم‌گیری مسئولانه
                    </h2>
                    <p className="text-gray-300 max-w-3xl mx-auto mb-6">
                        وِت‌اسیست برای تقویت توانمندی‌های شما طراحی شده است —
                        نه کاهش آن. با ترکیب دانش تخصصی شما و قابلیت‌های هوش مصنوعی،
                        می‌توانیم سطح مراقبت‌های دامپزشکی را ارتقا دهیم.
                    </p>
                    <div className="flex flex-col sm:flex-row gap-4 justify-center">
                        <Link href="/diseases" className="inline-flex items-center justify-center px-6 py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white font-medium rounded-xl shadow-lg hover:from-blue-400 hover:to-blue-500 active:scale-95 transition-all">
                            کاوش در کتابخانه بیماری‌ها
                        </Link>
                        <Link href="/diagnose" className="inline-flex items-center justify-center px-6 py-3 border border-white/20 text-gray-200 font-medium rounded-xl bg-white/5 hover:bg-white/10 active:scale-95 transition-all">
                            شروع فرآیند تشخیص
                        </Link>
                    </div>
                </div>

                {/* Footer Note */}
                <div className="text-center mt-12 text-sm text-gray-500">
                    <p>
                        این راهنما بر اساس اصول اخلاقی کالج دامپزشکی آمریکا (AVMA) و
                        اصول استفاده از هوش مصنوعی در پزشکی تهیه شده است.
                    </p>
                </div>
            </div>
        </div>
    );
}