// app/(dashboard)/diagnose/DiagnoseStepContainer.tsx
"use client";

import React from "react";
import {COLORS, GRADIENTS, STYLES} from "@/lib/theme";

type Props = {
    currentStep: number;
    totalSteps: number;
    title: string;
    subtitle?: string;
    children: React.ReactNode;
    canContinue?: boolean;
    canBack?: boolean;
    continueText?: string;
    onContinue: () => void;
    onBack?: () => void;
};

export default function DiagnoseStepContainer({
                                                  currentStep,
                                                  totalSteps,
                                                  title,
                                                  subtitle,
                                                  children,
                                                  canContinue = true,
                                                  continueText = "ادامه",
                                                  onContinue,
                                                  onBack,
                                                  canBack = true,
                                              }: Props) {
    return (
        <div className="w-full max-w-2xl">
            {/* 📊 بخش پیشرفت — با ظاهر حرفه‌ای */}
            <div className="text-center mb-8">
                <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-900/30 text-blue-200 text-xs font-medium mb-3">
                    <span className="w-1.5 h-1.5 rounded-full bg-blue-400 animate-pulse"></span>
                    مرحله {currentStep} از {totalSteps}
                </div>

                <h1
                    className="text-2xl sm:text-3xl font-bold leading-tight"
                    style={{
                        ...STYLES.glowText, // ✅ همان گرادیان عدد 404
                        letterSpacing: "-0.02em",
                    }}
                >
                    {title}
                </h1>

                {subtitle && (
                    <p className="text-base text-gray-400 mt-3 max-w-prose mx-auto leading-relaxed">
                        {subtitle}
                    </p>
                )}
            </div>

            {/* 📋 محتوای مرحله — در یک لایهٔ نرم */}
            <div
                className="rounded-2xl p-1 mb-8"
                style={{
                    background: `linear-gradient(135deg, ${COLORS.primary}20, ${COLORS.secondary}10)`,
                }}
            >
                <div
                    className="rounded-xl bg-black/40 backdrop-blur-2xl border border-white/10 overflow-hidden"
                    style={{
                        WebkitBackdropFilter: "blur(48px) saturate(180%)",
                        backdropFilter: "blur(48px) saturate(180%)",
                        boxShadow: "0 10px 30px -10px rgba(0, 0, 0, 0.5)",
                    }}
                >
                    {children}
                </div>
            </div>

            {/* 🧭 دکمه‌های ناوبری — با ظاهر نئونی-شیشه‌ای */}
            {/* 🧭 دکمه‌های ناوبری — با ظاهر نئونی-شیشه‌ای */}
            <div
                className={`flex gap-3 ${onBack ? "justify-between" : "justify-end"}`}
            >
                {/* 🔹 Continue button first */}
                <button
                    onClick={onContinue}
                    disabled={!canContinue}
                    aria-disabled={!canContinue}
                    className={`flex-1 sm:flex-none px-5 py-3.5 rounded-xl font-semibold text-white relative overflow-hidden
             transition-all duration-300 shadow-lg
             ${canContinue
                        ? "hover:shadow-xl active:scale-[0.98]"
                        : "opacity-70 cursor-not-allowed"
                    }`}
                    style={{
                        background: canContinue
                            ? GRADIENTS.button
                            : "rgba(100, 116, 139, 0.4)",
                        WebkitBackdropFilter: "blur(12px)",
                        backdropFilter: "blur(12px)",
                        boxShadow: canContinue
                            ? "0 4px 12px rgba(59, 130, 246, 0.2), 0 0 0 1px rgba(59, 130, 246, 0.1)"
                            : "0 2px 6px rgba(0, 0, 0, 0.1)",
                    }}
                >
        <span className="flex items-center justify-center gap-1.5">
            {continueText}
            {canContinue && currentStep < 5 && (
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-4 w-4"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                >
                    <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M9 5l7 7-7 7"
                    />
                </svg>
            )}
        </span>
                    {canContinue && (
                        <>
                            <div
                                className="absolute inset-0 rounded-xl pointer-events-none opacity-0 group-hover:opacity-100 transition-opacity"
                                style={{
                                    boxShadow: "0 0 0 2px rgba(96, 165, 250, 0.4), 0 0 16px rgba(96, 165, 250, 0.2)",
                                }}
                            />
                            <div
                                className="absolute inset-0 pointer-events-none opacity-30"
                                style={{
                                    background: `radial-gradient(circle at 80% 20%, rgba(96, 165, 250, 0.2) 0%, transparent 80%)`,
                                }}
                            />
                        </>
                    )}
                </button>

                {/* 🔹 Back button second */}
                {onBack && (
                    <button
                        onClick={onBack}
                        disabled={!canBack}
                        aria-disabled={!canBack}
                        className={`"flex-1 sm:flex-none px-5 py-3.5 rounded-xl font-medium
                   text-gray-200 relative overflow-hidden
                   border border-white/10 bg-white/5
                   hover:bg-white/10 active:scale-[0.98]
                   transition-all duration-300
                   shadow-sm hover:shadow-md"
                   ${canBack
                            ? "hover:shadow-xl active:scale-[0.98]"
                            : "opacity-70 cursor-not-allowed"
                        }    `}
                        style={{
                            WebkitBackdropFilter: "blur(12px)",
                            backdropFilter: "blur(12px)",
                        }}
                    >
            <span className="flex items-center justify-center gap-1.5">
                {/*<svg*/}
                {/*    xmlns="http://www.w3.org/2000/svg"*/}
                {/*    className="h-4 w-4 rtl:rotate-180"*/}
                {/*    fill="none"*/}
                {/*    viewBox="0 0 24 24"*/}
                {/*    stroke="currentColor"*/}
                {/*>*/}
                {/*    <path*/}
                {/*        strokeLinecap="round"*/}
                {/*        strokeLinejoin="round"*/}
                {/*        strokeWidth={2}*/}
                {/*        d="M15 19l-7-7 7-7"*/}
                {/*    />*/}
                {/*</svg>*/}
                بازگشت
            </span>
                        <div
                            className="absolute inset-0 pointer-events-none opacity-20"
                            style={{
                                background: `radial-gradient(circle at 20% 80%, rgba(96, 165, 250, 0.1) 0%, transparent 80%)`,
                            }}
                        />
                    </button>
                )}
            </div>
        </div>
    );
}