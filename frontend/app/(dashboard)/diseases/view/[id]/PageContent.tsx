"use client";

import {useParams, useRouter} from "next/navigation";
import {useBreadcrumbs} from "@/context/BreadcrumbContext";
import {useEffect, useMemo, useState} from "react";
import {Disease} from "@/types/model/Disease";
import diseaseService from "@/services/DiseaseService";
import {COLORS, STYLES} from "@/lib/theme";
import {Skeleton} from "@shared/components/ui/skeleton";
import {Card, CardContent, CardHeader, CardTitle} from "@shared/components/ui/card";
import {Button} from "@shared/components/ui/button";
import {AlertCircle, ChevronLeft, Heart, Info, PawPrint, Scale, ScrollText, Stethoscope, Syringe} from "lucide-react";
import {Badge} from "@shared/components/ui/badge";
import {DiseaseTypeEnum} from "@/types/enum/DiseaseTypeEnum";
import {SourceEnum} from "@/types/enum/SourceEnum";
import {SpeciesEnum} from "@/types/enum/SpeciesEnum";
import {SymptomEnum} from "@/types/enum/SymptomEnum";
import {Accordion, AccordionContent, AccordionItem, AccordionTrigger} from "@shared/components/ui/accordion";
import {DiagnosticMethodEnum} from "@/types/enum/DiagnosticMethodEnum";
import {TreatmentTypeEnum} from "@/types/enum/TreatmentTypeEnum";

export default function DiseaseDetailViewContent() {
    const router = useRouter();
    const params = useParams<{ id: string }>();
    const { setBreadcrumbs } = useBreadcrumbs();

    const diseaseId = params?.id ? Number(params.id) : null;
    const [disease, setDisease] = useState<Disease | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const [mounted, setMounted] = useState(false);

    useEffect(() => { setMounted(true); }, []);

    // Fetch disease
    useEffect(() => {
        if (!diseaseId) return;

        const fetchDisease = async () => {
            try {
                const data = await diseaseService.getById(diseaseId);
                setDisease(data);
            } catch (error) {
                console.error("Error fetching disease:", error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchDisease();
    }, [diseaseId]);

    useEffect(() => {
        if (disease) {
            setBreadcrumbs([
                { label: "خانه", href: "/" },
                { label: "کتابخانه بیماری‌ها", href: "/diseases" },
                { label: disease.name, href: "" },
            ]);
        }
    }, [disease, setBreadcrumbs]);

    const handleBack = () => router.back();

    // 🎨 رنگ‌کد بخش‌ها — بر اساس نوع بیماری (قلبی/تنفسی/...)
    const diseaseColor = useMemo(() => {
        if (!disease) return COLORS.primary;
        if (disease.type === "CONGENITAL") return "#f87171"; // قرمز-نارنجی (قلب)
        if (disease.type === "VASCULAR") return "#38bdf8"; // آبی (تنفسی)
        if (disease.type === "NEOPLASTIC") return "#c084fc"; // بنفش (عصبی)
        return COLORS.primary;
    }, [disease]);

    // 🔤 فعال‌سازی فونت
    useEffect(() => {
        document.documentElement.style.setProperty('--font-vazir', '"Vazir", sans-serif');
    }, []);

    // === LOADING SKELETON ===
    if (isLoading || !disease) {
        return (
            <div
                className="min-h-screen relative overflow-hidden"
                style={{ background: `radial-gradient(circle at 30% 30%, ${COLORS.primary}10, transparent 70%), #000` }}
            >
                <div className="absolute inset-0 opacity-5">
                    <div className="absolute top-1/4 left-1/3 w-96 h-96 bg-blue-500 rounded-full blur-[120px] animate-pulse"></div>
                </div>

                <div className="max-w-6xl mx-auto px-4 py-8">
                    {/* Header Skeleton */}
                    <div className="flex items-center gap-4 mb-8">
                        <Skeleton className="h-10 w-10 rounded-full" />
                        <div className="space-y-2 flex-1">
                            <Skeleton className="h-8 w-3/4" />
                            <Skeleton className="h-4 w-1/2" />
                        </div>
                    </div>

                    {/* Badges */}
                    <div className="flex flex-wrap gap-2 mb-8">
                        {[...Array(3)].map((_, i) => (
                            <Skeleton key={i} className="h-7 w-24 rounded-full" />
                        ))}
                    </div>

                    {/* Cards */}
                    <div className="space-y-6">
                        {[...Array(4)].map((_, idx) => (
                            <Card
                                key={idx}
                                className="overflow-hidden border-white/10"
                                style={{
                                    background: "rgba(255, 255, 255, 0.03)",
                                    backdropFilter: "blur(12px)",
                                }}
                            >
                                <CardHeader>
                                    <Skeleton className="h-6 w-48" />
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <Skeleton className="h-4 w-full" />
                                    <Skeleton className="h-4 w-5/6" />
                                    <Skeleton className="h-4 w-4/6" />
                                </CardContent>
                            </Card>
                        ))}
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div
            className="min-h-screen relative overflow-hidden font-vazir"
            style={{
                fontFamily: '"Vazir", sans-serif',
                background: `
          radial-gradient(circle at 20% 30%, rgba(59, 130, 246, 0.03) 0%, transparent 50%),
          radial-gradient(circle at 80% 70%, rgba(147, 51, 234, 0.02) 0%, transparent 60%),
          #000000
        `,
            }}
        >
            {/* نور پس‌زمینه */}
            <div className="absolute top-1/4 left-1/4 w-80 h-80 bg-blue-500 rounded-full blur-[120px] opacity-10 animate-pulse"></div>
            <div className="absolute bottom-1/3 right-1/3 w-72 h-72 bg-indigo-600 rounded-full blur-[100px] opacity-5 animate-pulse delay-700"></div>

            <div className="max-w-6xl mx-auto px-4 py-6">
                {/* 🔙 Back Button + Title */}
                <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4 mb-8">
                    <div className="flex items-start gap-4">
                        <Button
                            variant="ghost"
                            size="icon"
                            onClick={handleBack}
                            className="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 text-gray-200 hover:text-white transition-all"
                            style={{
                                WebkitBackdropFilter: "blur(12px)",
                                backdropFilter: "blur(12px)",
                            }}
                        >
                            <ChevronLeft className="h-5 w-5" />
                        </Button>

                        <div>
                            <h1
                                className="text-2xl md:text-3xl font-bold text-gray-100 mb-2 leading-tight"
                                style={STYLES.glowText}
                            >
                                {disease.per_name}
                            </h1>

                            <div className="flex flex-wrap gap-2 mt-2">
                                <Badge
                                    className="text-sm px-3 py-1.5 rounded-full"
                                    style={{
                                        background: `${diseaseColor}20`,
                                        color: `${diseaseColor}`,
                                        border: `1px solid ${diseaseColor}40`,
                                    }}
                                >
                                    {DiseaseTypeEnum[disease.type]?.label || "نامشخص"}
                                </Badge>

                                {disease.fromValidSources && (
                                    <Badge className="bg-emerald-500/20 text-emerald-300 border-emerald-500/40 text-sm px-3 py-1.5 rounded-full">
                                        ✅ منبع معتبر
                                    </Badge>
                                )}

                                {disease.source && (
                                    <Badge className="bg-blue-500/20 text-blue-300 border-blue-500/40 text-sm px-3 py-1.5 rounded-full">
                                        {SourceEnum[disease.source]?.label || disease.source}
                                    </Badge>
                                )}
                            </div>
                        </div>
                    </div>
                </div>

                {/* 📌 Overview — با ظاهر تخصصی */}
                <Card
                    className="mb-8 overflow-hidden border"
                    style={{
                        ...STYLES.glassPanel,
                        border: `1px solid ${COLORS.glassBorder}`,
                    }}
                >
                    <CardHeader className="border-b border-white/10 pb-4">
                        <CardTitle className="flex items-center gap-2.5 text-gray-100">
                            <Info className="h-5 w-5 text-blue-400" />
                            <span>مرور کلی</span>
                        </CardTitle>
                    </CardHeader>
                    <CardContent className="pt-5 space-y-5">
                        {disease.per_description && (
                            <p className="text-gray-300 leading-relaxed">
                                {disease.per_description.replace(".", "")}
                            </p>
                        )}

                        {disease.whyImportant_per && (
                            <div
                                className="rounded-xl p-4 border border-blue-500/20"
                                style={{ background: "rgba(59, 130, 246, 0.05)" }}
                            >
                                <div className="flex items-start gap-3">
                                    <AlertCircle className="h-5 w-5 text-blue-400 mt-0.5 flex-shrink-0" />
                                    <div>
                                        <h3 className="font-bold text-blue-200 mb-1.5">چرا مهم است؟</h3>
                                        <p className="text-blue-100">{disease.whyImportant_per}</p>
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Species */}
                        {disease.affected_species?.length > 0 && (
                            <div>
                                <h3 className="font-medium text-gray-200 mb-3 flex items-center gap-2">
                                    <PawPrint className="h-4 w-4 text-amber-400" />
                                    گونه‌های درگیر
                                </h3>
                                <div className="flex flex-wrap gap-2">
                                    {disease.affected_species.map((species) => (
                                        <Badge
                                            key={species}
                                            className="text-sm px-3 py-1.5 rounded-full bg-amber-500/10 text-amber-200 border-amber-500/30"
                                        >
                                            {SpeciesEnum[species]?.label || species}
                                        </Badge>
                                    ))}
                                </div>
                            </div>
                        )}

                        {/* Main Symptom */}
                        {disease.mainSymptom && (
                            <div>
                                <h3 className="font-medium text-gray-200 mb-2">علامت اصلی</h3>
                                <Badge className="text-sm px-4 py-2 rounded-xl bg-red-500/10 text-red-200 border-red-500/30">
                                    {SymptomEnum[disease.mainSymptom]?.persianValue || disease.mainSymptom}
                                </Badge>
                            </div>
                        )}

                        {/* All Symptoms */}
                        {disease.symptoms?.length > 0 && (
                            <div>
                                <h3 className="font-medium text-gray-200 mb-3">علائم همراه</h3>
                                <div className="flex flex-wrap gap-2">
                                    {disease.symptoms.filter((s) => s !== disease.mainSymptom).map((symptom) => (
                                        <Badge
                                            key={symptom}
                                            variant="outline"
                                            className="text-xs px-2.5 py-1 bg-white/5 text-gray-300 border-white/10"
                                        >
                                            {SymptomEnum[symptom]?.persianValue || symptom}
                                        </Badge>
                                    ))}
                                </div>
                            </div>
                        )}
                    </CardContent>
                </Card>

                {/* ❤️ Stages — برای بیماری‌های قلبی */}
                {disease.stages?.length > 0 && (
                    <Card
                        className="mb-8 overflow-hidden border"
                        style={STYLES.glassPanel}
                    >
                        <CardHeader className="border-b border-white/10 pb-4">
                            <CardTitle className="flex items-center gap-2.5 text-gray-100">
                                <Scale className="h-5 w-5 text-purple-400" />
                                <span>مراحل بیماری</span>
                            </CardTitle>
                        </CardHeader>
                        <CardContent>
                            <Accordion type="single" collapsible className="w-full">
                                {disease.stages.map((stage, index) => (
                                    <AccordionItem
                                        key={stage.id || index}
                                        value={`stage-${index}`}
                                        className="border-b border-white/10 last:border-0"
                                    >
                                        <AccordionTrigger className="text-lg font-medium text-gray-200 hover:text-gray-100 py-4">
                                            {stage.per_name || `مرحله ${index + 1}`}
                                        </AccordionTrigger>
                                        <AccordionContent className="pt-2 pb-4 text-gray-300">
                                            {stage.per_description && <p className="mb-3">{stage.per_description.replace(".", "")}</p>}

                                            {stage.symptoms?.length > 0 && (
                                                <div>
                                                    <h4 className="font-medium text-gray-200 mb-2 flex items-center gap-1.5">
                                                        <Heart className="h-4 w-4 text-red-400" />
                                                        علائم مرحله
                                                    </h4>
                                                    <div className="flex flex-wrap gap-2">
                                                        {stage.symptoms.map((symptom) => (
                                                            <Badge
                                                                key={symptom}
                                                                variant="outline"
                                                                className="text-xs px-2 py-1 bg-red-500/10 text-red-300 border-red-500/30"
                                                            >
                                                                {SymptomEnum[symptom]?.persianValue || symptom}
                                                            </Badge>
                                                        ))}
                                                    </div>
                                                </div>
                                            )}
                                        </AccordionContent>
                                    </AccordionItem>
                                ))}
                            </Accordion>
                        </CardContent>
                    </Card>
                )}

                {/* 🩺 Diagnosis */}
                {disease.diagnoses?.length > 0 && (
                    <Card
                        className="mb-8 overflow-hidden border"
                        style={STYLES.glassPanel}
                    >
                        <CardHeader className="border-b border-white/10 pb-4">
                            <CardTitle className="flex items-center gap-2.5 text-gray-100">
                                <Stethoscope className="h-5 w-5 text-green-400" />
                                <span>روش‌های تشخیصی</span>
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-5">
                            {disease.diagnoses.map((diag, index) => (
                                <div
                                    key={diag.id || index}
                                    className="p-4 rounded-xl border border-green-500/20"
                                    style={{ background: "rgba(34, 197, 94, 0.05)" }}
                                >
                                    <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-2 mb-3">
                                        <h3 className="font-bold text-green-200 text-lg">
                                            {DiagnosticMethodEnum[diag.type]?.label || diag.type}
                                        </h3>
                                        <Badge className="bg-green-500/20 text-green-200 border-green-500/40">
                                            {DiagnosticMethodEnum[diag.type]?.label || diag.type}
                                        </Badge>
                                    </div>

                                    {diag.per_name && <p className="text-green-100 font-medium mb-2">{diag.per_name}</p>}
                                    {diag.per_description && <p className="text-gray-300">{diag.per_description.replace(".", "")}</p>}
                                </div>
                            ))}
                        </CardContent>
                    </Card>
                )}

                {/* 💉 Treatment */}
                {disease.treatments?.length > 0 && (
                    <Card
                        className="mb-8 overflow-hidden border"
                        style={STYLES.glassPanel}
                    >
                        <CardHeader className="border-b border-white/10 pb-4">
                            <CardTitle className="flex items-center gap-2.5 text-gray-100">
                                <Syringe className="h-5 w-5 text-amber-400" />
                                <span>گزینه‌های درمانی</span>
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            {disease.treatments.map((treat, index) => (
                                <div
                                    key={treat.id || index}
                                    className="rounded-xl p-5 border border-amber-500/20"
                                    style={{ background: "rgba(234, 179, 8, 0.05)" }}
                                >
                                    <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3 mb-4">
                                        <div>
                                            <h3 className="font-bold text-amber-200">
                                                {TreatmentTypeEnum[treat.type]?.label || treat.type}
                                            </h3>
                                            {treat.per_name && <p className="font-medium text-amber-100">{treat.per_name}</p>}
                                        </div>
                                        <Badge className="bg-amber-500/20 text-amber-200 border-amber-500/40">
                                            {TreatmentTypeEnum[treat.type]?.label || treat.type}
                                        </Badge>
                                    </div>

                                    {treat.per_description && (
                                        <p className="text-gray-300 mb-4">{treat.per_description.replace(".", "")}</p>
                                    )}

                                    {/* Medicines */}
                                    {treat.medicines?.length > 0 && (
                                        <div className="space-y-4">
                                            <h4 className="font-bold text-amber-200 mb-2 flex items-center gap-1.5">
                                                <Syringe className="h-4 w-4" />
                                                داروهای تجویزی
                                            </h4>
                                            <div className="space-y-4">
                                                {treat.medicines.map((med, mIdx) => (
                                                    <div
                                                        key={mIdx}
                                                        className="bg-gray/60 rounded-xl p-4 border border-white/10"
                                                        style={{
                                                            WebkitBackdropFilter: "blur(12px)",
                                                            backdropFilter: "blur(12px)",
                                                        }}
                                                    >
                                                        <h5 className="font-bold text-gray-100 mb-1.5">{med.name}</h5>
                                                        <p className="text-gray-400 text-sm mb-3">{med.per_description.replace(".", "") || "هدف درمانی مشخص نشده"}</p>

                                                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm">
                                                            {med.dogDosage && (
                                                                <div className="flex items-start gap-2">
                                                                    <span className="text-amber-400 flex-shrink-0">🐶</span>
                                                                    <span className="text-amber-50"><span className="text-amber-700 font-medium">سگ:</span> {med.dogDosage}</span>
                                                                </div>
                                                            )}
                                                            {med.catDosage && (
                                                                <div className="flex items-start gap-2">
                                                                    <span className="text-amber-400 flex-shrink-0">🐱</span>
                                                                    <span className="text-amber-50"><span className="text-amber-400 font-medium">گربه:</span> {med.catDosage}</span>
                                                                </div>
                                                            )}
                                                            {med.contraindications && (
                                                                <div className="col-span-full flex items-start gap-2">
                                                                    <span className="text-red-400 mt-0.5">⚠️</span>
                                                                    <span className="text-red-500">
                                    <span className="font-medium text-red-300">ممنوعیت‌ها:</span> {med.contraindications}
                                  </span>
                                                                </div>
                                                            )}
                                                        </div>
                                                    </div>
                                                ))}
                                            </div>
                                        </div>
                                    )}
                                </div>
                            ))}
                        </CardContent>
                    </Card>
                )}

                {/* 📊 Differential & Relevance */}
                {(disease.differentialDiseasesStr || disease.irrelevantScore !== undefined) && (
                    <Card
                        className="overflow-hidden border"
                        style={STYLES.glassPanel}
                    >
                        <CardHeader className="border-b border-white/10 pb-4">
                            <CardTitle className="flex items-center gap-2.5 text-gray-100">
                                <ScrollText className="h-5 w-5 text-red-400" />
                                <span>تشخیص‌های تفاضلی</span>
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-5">
                            {disease.differentialDiseasesStr && (
                                <div>
                                    <div className="bg-red-500/5 border border-red-500/20 rounded-xl p-4 text-gray-300">
                                        {disease.differentialDiseasesStr}
                                    </div>
                                </div>
                            )}
                        </CardContent>
                    </Card>
                )}
            </div>
        </div>
    );
}