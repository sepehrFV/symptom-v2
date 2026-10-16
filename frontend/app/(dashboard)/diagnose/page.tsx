// app/diagnose/page.tsx
"use client";

import {useEffect, useState} from "react";
import DiagnosisService from "@/services/DiagnosisService";
import {Answer, Intake, MetaResponse, SignInfo} from "@/types/diagnosis";
import {COLORS, GRADIENTS, STYLES} from "@/lib/theme"; // ✅ تم مرکزی
// کامپوننت‌های مراحل (همان‌ها — فقط استایل داخلشون باید به‌روز بشه)
import StepSelectSpecies from "@/app/(dashboard)/diagnose/stepSelectSpecies";
import StepPatientInfo from "@/app/(dashboard)/diagnose/stepPatientInfo";
import StepComplaints from "@/app/(dashboard)/diagnose/stepComplaints";
import StepInterview from "@/app/(dashboard)/diagnose/stepInterview";
import StepDiagnosisResult from "@/app/(dashboard)/diagnose/stepDiagnosisResult";

export default function DiagnosePage() {
    const [meta, setMeta] = useState<MetaResponse | null>(null);
    const [metaError, setMetaError] = useState<string | null>(null);
    const [intake, setIntake] = useState<Intake>({
        species: null, petName: "", ageGroup: null, breedGroup: "unknown", audience: "owner", mode: "combined",
    });
    const [signs, setSigns] = useState<SignInfo[]>([]);
    const [complaints, setComplaints] = useState<string[]>([]);   // signs the user ticked = "yes", sent as `initial`
    const [answers, setAnswers] = useState<Record<string, Answer>>({});

    useEffect(() => {
        DiagnosisService.getMeta().then(setMeta).catch((e) => setMetaError(e.message));
    }, []);

    // the question wording/levels depend on the audience -> reload signs when it changes
    useEffect(() => { setSigns([]); setComplaints([]); setAnswers({}); }, [intake.audience]);

    // answers = ticked complaints (yes) + interview answers
    const allAnswers: Record<string, Answer> = {
        ...Object.fromEntries(complaints.map((id) => [id, "yes" as Answer])),
        ...answers,
    };

    const restart = () => {
        setIntake({species: null, petName: "", ageGroup: null, breedGroup: "unknown", audience: "owner", mode: "combined"});
        setSigns([]);
        setComplaints([]);
        setAnswers({});
        setCurrentStep(1);
    };

    const [currentStep, setCurrentStep] = useState<number>(1);
    const TOTAL_STEPS = 5;

    const handleNextStep = () => setCurrentStep((prev) => prev + 1);
    const handleBackStep = () => setCurrentStep((prev) => prev - 1);

    // ✨ عنوان‌های مراحل — با توضیح کوتاه حرفه‌ای
    const steps = [
        { title: "گونه حیوان", subtitle: "سگ یا گربه؟" },
        { title: "اطلاعات بیمار", subtitle: "نام، سن، جنسیت و سابقه" },
        { title: "علائم اصلی", subtitle: "چه یافته‌هایی مشاهده شده؟" },
        { title: "پرسش‌های تفکیکی", subtitle: "یک پرسش در هر مرحله، متناسب با پاسخ‌های قبلی" },
        { title: "گزارش نهایی", subtitle: "لیست بیماری‌های احتمالی" },
    ];

    // ✅ افکت نور پس‌زمینه — ظریف و ثابت
    useEffect(() => {
        const style = document.createElement("style");
        style.textContent = `
      @keyframes floatGlow {
        0%, 100% { opacity: 0.08; }
        50% { opacity: 0.15; }
      }
    `;
        document.head.appendChild(style);
        return () => {
            document.head.removeChild(style);
        };
    }, []);

    return (
        <main
            className="min-h-screen flex flex-col items-center px-4 sm:px-6 py-8 relative overflow-hidden"
            style={{
                background: `
          radial-gradient(circle at 20% 30%, rgba(59, 130, 246, 0.03) 0%, transparent 50%),
          radial-gradient(circle at 80% 70%, rgba(147, 51, 234, 0.02) 0%, transparent 60%),
          #000000
        `,
            }}
        >
            {/* نورهای پس‌زمینه — ظریف و ثابت (برای عمق) */}
            <div className="absolute top-1/4 left-1/4 w-80 h-80 bg-blue-500 rounded-full blur-[120px] opacity-10 animate-pulse"></div>
            <div className="absolute bottom-1/3 right-1/3 w-72 h-72 bg-indigo-600 rounded-full blur-[100px] opacity-5 animate-pulse delay-700"></div>

            {/* 📊 نوار پیشرفت — با ظاهر حرفه‌ای و انیمیشن هوشمند */}
            <div className="w-full max-w-4xl mb-10">
                <div className="flex justify-between items-center text-sm text-gray-400 mb-3">
                    <span className="font-medium">مرحله {currentStep} از {TOTAL_STEPS}</span>
                    <span className="bg-blue-900/30 px-3 py-1 rounded-full text-xs">
            {steps[currentStep - 1].subtitle}
          </span>
                </div>
                <div className="h-2 bg-white/5 rounded-full overflow-hidden border border-white/5">
                    <div
                        className="h-full rounded-full transition-all duration-700 ease-out"
                        style={{
                            width: `${((currentStep - 1) / (TOTAL_STEPS - 1)) * 100}%`,
                            background: GRADIENTS.title, // ✅ همان گرادیان 404
                            boxShadow: `inset 0 0 12px ${COLORS.glow}`,
                        }}
                    />
                </div>
            </div>

            {/* 📋 محتوای مراحل — در یک کارت شیشه‌ای */}
            <div className="w-full max-w-2xl">
                <div
                    className="rounded-2xl overflow-hidden border transition-all duration-500"
                    style={{
                        ...STYLES.glassPanel,
                        boxShadow: `
              0 25px 50px -12px rgba(0, 0, 0, 0.5),
              inset 0 1px 0 rgba(255, 255, 255, 0.05)
            `,
                    }}
                >
                    {/* عنوان مرحله — با ظاهر تخصصی */}
                    <div
                        className="px-6 py-4 border-b border-white/5 bg-black/20"
                        style={{
                            background: `
                linear-gradient(90deg, rgba(0,0,0,0.3), transparent),
                ${GRADIENTS.glowBlue}
              `,
                        }}
                    >
                        <h2
                            className="text-xl font-bold text-gray-100"
                            style={STYLES.glowText} // ✅ مثل عدد 404
                        >
                            {steps[currentStep - 1].title}
                        </h2>
                    </div>

                    {/* محتوای مرحله */}
                    <div className="p-6">
                        {metaError && <p className="text-rose-300 text-sm mb-4">{metaError}</p>}

                        {currentStep === 1 && (
                            <StepSelectSpecies
                                onSelect={(species) => {
                                    const id = species === "CANINE" ? "dog" : "cat";
                                    // a different species invalidates breed, signs and answers
                                    setIntake((prev) => ({...prev, species: id, breedGroup: "unknown"}));
                                    setComplaints([]);
                                    setAnswers({});
                                    handleNextStep();
                                }}
                                currentStep={currentStep}
                                totalSteps={TOTAL_STEPS}
                            />
                        )}

                        {currentStep === 2 && (
                            <StepPatientInfo
                                meta={meta}
                                intake={intake}
                                setIntake={setIntake}
                                onNext={handleNextStep}
                                onBack={handleBackStep}
                            />
                        )}

                        {currentStep === 3 && (
                            <StepComplaints
                                intake={intake}
                                signs={signs}
                                setSigns={setSigns}
                                selected={complaints}
                                setSelected={setComplaints}
                                onNext={() => { setAnswers({}); handleNextStep(); }}
                                onBack={handleBackStep}
                            />
                        )}

                        {currentStep === 4 && (
                            <StepInterview
                                intake={intake}
                                initial={complaints}
                                answers={allAnswers}
                                setAnswers={(all) => {
                                    // keep only interview answers (not the ticked complaints)
                                    setAnswers(Object.fromEntries(Object.entries(all).filter(([k]) => !complaints.includes(k))));
                                }}
                                onFinish={handleNextStep}
                                onBack={handleBackStep}
                            />
                        )}

                        {currentStep === 5 && (
                            <StepDiagnosisResult
                                intake={intake}
                                initial={complaints}
                                answers={allAnswers}
                                onBack={handleBackStep}
                                onRestart={restart}
                            />
                        )}
                    </div>
                </div>

                {/* ✨ نقطهٔ نئونی — نشانگر "در حال استفاده از هوش مصنوعی" */}
                {currentStep >= 3 && (
                    <div className="mt-6 flex items-center justify-center text-gray-500 text-sm">
            <span className="flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-blue-500 animate-pulse"></span>
              در حال پردازش با مدل‌های تخصصی دامپزشکی...
            </span>
                    </div>
                )}
            </div>
        </main>
    );
}