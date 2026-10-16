// src/lib/theme.ts

// 🎨 رنگ‌های کلیدی — بر اساس طیف آبی-بنفش هویت فعلی
export const COLORS = {
    primary: "#60a5fa",        // blue-400 — پایه اصلی
    primaryLight: "#93c5fd",   // blue-300
    secondary: "#a78bfa",      // violet-300
    accent: "#818cf8",         // indigo-400 (برای transition smooth)
    glow: "rgba(96, 165, 250, 0.4)",
    textPrimary: "#f9fafb",    // gray-50 — برای عناوین اصلی
    textSecondary: "#d1d5db",  // gray-300
    glassBorder: "rgba(255, 255, 255, 0.1)",
    glassBg: "rgba(255, 255, 255, 0.05)",
};

// 🌈 گرادیان‌های استاندارد
export const GRADIENTS = {
    // همان گرادیان عدد 404 — برای عناوین تأثیرگذار
    title: "linear-gradient(145deg, #60a5fa, #818cf8, #a78bfa)",

    // برای زیرعنوان‌ها یا دکمه‌های ثانویه
    subtitle: "linear-gradient(145deg, #93c5fd, #a5b4fc, #c7d2fe)",

    // برای دکمه‌های اصلی (مثل بازگشت به خانه)
    button: "linear-gradient(90deg, #3b82f6, #6366f1)",

    // پس‌زمینه‌های نورپردازی پویا
    glowBlue: "radial-gradient(circle at 30% 30%, rgba(59, 130, 246, 0.08) 0%, transparent 40%)",
    glowPurple: "radial-gradient(circle at 70% 70%, rgba(147, 51, 234, 0.06) 0%, transparent 50%)",
};

// ⚙️ انیمیشن‌های کلیدی — برای mount و hover
export const ANIMATIONS = {
    // برای ورود اولیه المان‌ها
    fadeInUp: (delayMs = 0) => ({
        initial: { opacity: 0, y: 20 },
        animate: { opacity: 1, y: 0 },
        transition: { duration: 0.7, ease: "easeOut", delay: delayMs / 1000 },
    }),

    // برای تعامل کارت‌ها (در صورت استفاده از framer-motion بعداً)
    cardHover: {
        scale: 1.02,
        boxShadow: [
            "0 20px 40px -15px rgba(0,0,0,0.6)",
            "inset 0 1px 0 rgba(255,255,255,0.05)",
            "inset 0 -1px 0 rgba(0,0,0,0.3)",
            "0 0 0 2px rgba(96,165,250,0.3)",
            "0 0 20px rgba(96,165,250,0.15)",
        ].join(", "),
    },
};

// 🖼️ افکت‌های ظاهری ثابت
export const STYLES = {
    glassPanel: {
        background: COLORS.glassBg,
        border: `1px solid ${COLORS.glassBorder}`,
        backdropFilter: "blur(64px) saturate(180%)",
        WebkitBackdropFilter: "blur(64px) saturate(180%)",
        borderRadius: "1.5rem", // rounded-2xl
    } as React.CSSProperties,

    glowText: {
        background: GRADIENTS.title,
        WebkitBackgroundClip: "text",
        backgroundClip: "text",
        color: "transparent",
        textShadow: "0 0 16px rgba(96, 165, 250, 0.3)",
    } as React.CSSProperties,
};