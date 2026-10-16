// app/(dashboard)/diagnose/StepSelectSpecies.tsx
"use client";

import Image from "next/image";
import { useState, useEffect } from "react";
import { SpeciesEnum, SpeciesEnumType } from "@/types/enum/SpeciesEnum";
import DiagnoseStepContainer from "@/app/(dashboard)/diagnose/DiagnoseStepContainer";
// ✅ واردات تم مرکزی
import { COLORS, GRADIENTS } from "@/lib/theme";

type Props = {
    onSelect: (species: SpeciesEnumType) => void;
    currentStep: number;
    totalSteps: number;
};

const SPECIES_OPTIONS = Object.values(SpeciesEnum).map((species) => ({
    title: species.label,
    description: species.description,
    value: species.value,
    imgSrc: species.value === "CANINE" ? "/illustrations/dog.png" : "/illustrations/cat.png",
    glowColor: species.value === "CANINE"
        ? "rgba(59, 130, 246, 0.5)"   // آبی برای سگ
        : "rgba(147, 51, 234, 0.5)",  // بنفش برای گربه
}));

export default function StepSelectSpecies({ onSelect, currentStep, totalSteps }: Props) {
    const [selected, setSelected] = useState<SpeciesEnumType | null>(null);

    // برای جلوگیری از rehydration mismatch (چون image در CSR لود میشه)
    const [isMounted, setIsMounted] = useState(false);
    useEffect(() => setIsMounted(true), []);

    return (
        <DiagnoseStepContainer
            currentStep={currentStep}
            totalSteps={totalSteps}
            title="انتخاب گونه بیمار"
            subtitle="برای شروع فرآیند تشخیصی، گونه حیوان را انتخاب کنید"
            onContinue={() => {
                if (selected) {
                    onSelect(selected);
                }
            }}
            onBack={() => {}}
            canBack={false}
            canContinue={!!selected}
            continueText="ادامه"
        >
            {/*<div className="grid grid-cols-1 md:grid-cols-2 gap-6 w-full">*/}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 w-full">
                {SPECIES_OPTIONS.map((option) => {
                    const isSelected = selected === option.value;

                    return (
                        <button
                            key={option.value}
                            onClick={() => setSelected(option.value)}
                            className={`
                                          group relative overflow-hidden rounded-2xl w-full
                                          transition-all duration-500 ease-out
                                          ${isSelected
                                                          ? "scale-[1.02] shadow-xl z-10"
                                                          : "hover:scale-[1.01] hover:shadow-lg"
                                                      }
                                          bg-white/5 backdrop-blur-xl border border-white/10
                                          active:scale-[0.98]
                                        `}
                            aria-pressed={isSelected}
                            style={{
                                WebkitBackdropFilter: "blur(64px) saturate(180%)",
                                backdropFilter: "blur(64px) saturate(180%)",
                                boxShadow: isSelected
                                    ? `
                                      0 25px 50px -12px rgba(0, 0, 0, 0.5),
                                      inset 0 1px 0 rgba(255, 255, 255, 0.05),
                                      0 0 0 2px ${option.glowColor},
                                      0 0 20px ${option.glowColor}
                                    `
                                    : "0 10px 25px -5px rgba(0, 0, 0, 0.3)",
                            }}
                        >
                            {/* لایه گرادیان داخلی برای جلوهٔ شیشه */}
                            <div
                                className="absolute inset-0 pointer-events-none opacity-30"
                                style={{
                                    background: `
                                      radial-gradient(circle at 30% 30%, ${option.glowColor.replace("0.5", "0.1")} 0%, transparent 70%)
                                    `,
                                }}
                            />

                            <div className="p-6 flex flex-col items-center text-center relative z-10">
                                <div
                                    className={`relative h-32 w-32 sm:h-40 sm:w-40 mb-5 transition-transform duration-500 ${
                                        isSelected ? "scale-110" : "group-hover:scale-105"
                                    }`}
                                >
                                    {isMounted && (
                                        <Image
                                            src={option.imgSrc}
                                            alt={option.title}
                                            fill
                                            className="object-contain drop-shadow-sm"
                                        />
                                    )}
                                    {/* ✨ حلقهٔ نئونی دور تصویر — فقط در حالت انتخاب */}
                                    {isSelected && (
                                        <div
                                            className="absolute -inset-2 rounded-2xl pointer-events-none"
                                            style={{
                                                boxShadow: `0 0 0 3px ${option.glowColor}, 0 0 16px ${option.glowColor}`,
                                            }}
                                        />
                                    )}
                                </div>

                                <h3
                                    className={`text-xl font-bold transition-colors ${
                                        isSelected ? "text-blue-200" : "text-gray-100 group-hover:text-blue-100"
                                    }`}
                                    style={{
                                        textShadow: isSelected
                                            ? "0 0 12px rgba(96, 165, 250, 0.4)"
                                            : "0 1px 3px rgba(0,0,0,0.5)",
                                    }}
                                >
                                    {option.title}
                                </h3>

                                <p className="mt-2 text-sm text-gray-400 leading-relaxed">
                                    {option.description}
                                </p>

                                {/* ✅ تیک انتخاب — با انیمیشن ظریف */}
                                {isSelected && (
                                    <div className="absolute top-4 right-4 w-6 h-6 rounded-full bg-blue-500 flex items-center justify-center">
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            className="h-4 w-4 text-white"
                                            viewBox="0 0 20 20"
                                            fill="currentColor"
                                        >
                                            <path
                                                fillRule="evenodd"
                                                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                clipRule="evenodd"
                                            />
                                        </svg>
                                    </div>
                                )}
                            </div>

                            {/* لبهٔ درخشان — فقط در hover/selected */}
                            <div
                                className={`absolute inset-0 rounded-2xl pointer-events-none transition-opacity ${
                                    isSelected ? "opacity-100" : "group-hover:opacity-100 opacity-0"
                                }`}
                                style={{
                                    boxShadow: `0 0 0 2px ${option.glowColor}, 0 0 20px ${option.glowColor.replace("0.5", "0.2")}`,
                                }}
                            />
                        </button>
                    );
                })}
            </div>
        </DiagnoseStepContainer>
    );
}