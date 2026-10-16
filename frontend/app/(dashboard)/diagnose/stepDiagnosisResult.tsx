// app/(dashboard)/diagnose/stepDiagnosisResult.tsx
"use client";

import Link from "next/link";
import {useEffect, useRef, useState} from "react";
import DiagnosisService from "@/services/DiagnosisService";
import {Answer, DiagnosisResponse, Intake, KbDisease, RankedDisease} from "@/types/diagnosis";
import {
    BandChip, CARDIAC_BAND_FA, CARDIAC_COLOR, GlassButton, ScoreBar, Spinner, TriageBanner, URGENCY_FA,
} from "@/app/(dashboard)/diagnose/ui";

type Props = {
    intake: Intake;
    initial: string[];
    answers: Record<string, Answer>;
    onBack: () => void;
    onRestart: () => void;
};

const AGREEMENT_FA = {
    agree: {t: "دو موتور هم‌نظرند", c: "#34d399"},
    partial: {t: "دو موتور تا حدی هم‌نظرند", c: "#fbbf24"},
    disagree: {t: "دو موتور هم‌نظر نیستند — با احتیاط تفسیر کنید", c: "#f87171"},
} as const;

function DiseaseCard({d, showEngines}: { d: RankedDisease; showEngines: boolean }) {
    const [open, setOpen] = useState(d.rank === 1);
    return (
        <article className="rounded-2xl border border-white/10 bg-black/30 p-4">
            <header className="flex items-start justify-between gap-3 cursor-pointer" onClick={() => setOpen(!open)}>
                <div>
                    <h3 className="text-gray-100 font-semibold">{d.rank}. {d.name_fa}</h3>
                    <p className="text-xs text-gray-500 mt-0.5" dir="ltr">{d.name_en}</p>
                </div>
                <div className="flex flex-col items-end gap-1 shrink-0">
                    <BandChip band={d.band}/>
                    {d.urgency !== "routine" && <span className="text-[11px] text-amber-300">{URGENCY_FA[d.urgency]}</span>}
                </div>
            </header>
            <div className="mt-3 space-y-1.5">
                {showEngines ? (
                    <>
                        <ScoreBar value={d.rule_score} label="قاعده‌محور"/>
                        <ScoreBar value={d.ai_score} label="هوش مصنوعی"/>
                    </>
                ) : <ScoreBar value={d.score} label="تخمین"/>}
                <p className="text-[11px] text-gray-500">سهم نسبی در میان بیماری‌های قلبی (به شرط قلبی بودن علت)</p>
            </div>
            {open && (
                <div className="mt-4 space-y-3 text-sm">
                    {d.supporting.length > 0 && (
                        <div>
                            <div className="text-xs text-emerald-300 mb-1">یافته‌های موافق</div>
                            <div className="flex flex-wrap gap-1.5">
                                {d.supporting.slice(0, 6).map((e) => (
                                    <span key={e.sign} className="px-2 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/30 text-emerald-200 text-xs">
                                        {e.label_fa} ×{e.lr}
                                    </span>
                                ))}
                            </div>
                        </div>
                    )}
                    {d.against.length > 0 && (
                        <div>
                            <div className="text-xs text-rose-300 mb-1">یافته‌های مخالف</div>
                            <div className="flex flex-wrap gap-1.5">
                                {d.against.slice(0, 6).map((e) => (
                                    <span key={e.sign} className="px-2 py-0.5 rounded-full bg-rose-500/10 border border-rose-500/30 text-rose-200 text-xs">
                                        {e.answer === "no" ? "نبود " : ""}{e.label_fa} ×{e.lr}
                                    </span>
                                ))}
                            </div>
                        </div>
                    )}
                    {d.to_confirm.length > 0 && (
                        <div>
                            <div className="text-xs text-blue-300 mb-1">برای تأیید یا رد، این موارد را بررسی کنید</div>
                            <ul className="list-disc pr-5 text-gray-300 text-xs space-y-0.5">
                                {d.to_confirm.map((t) => <li key={t.sign}>{t.label_fa}</li>)}
                            </ul>
                        </div>
                    )}
                    {d.confirm_tests_en.length > 0 && (
                        <div dir="ltr" className="text-left">
                            <div className="text-xs text-blue-300 mb-1">Confirmatory work-up</div>
                            <ul className="list-disc pl-5 text-gray-300 text-xs space-y-0.5">
                                {d.confirm_tests_en.map((t) => <li key={t}>{t}</li>)}
                            </ul>
                        </div>
                    )}
                    {d.note_en && <p dir="ltr" className="text-left text-xs text-gray-400 leading-relaxed">{d.note_en}</p>}
                    {d.disease_id != null && (
                        <Link href={`/diseases/view/${d.disease_id}`} className="inline-block text-xs text-blue-300 underline">
                            مشاهدهٔ صفحهٔ بیماری
                        </Link>
                    )}
                </div>
            )}
        </article>
    );
}

export default function StepDiagnosisResult({intake, initial, answers, onBack, onRestart}: Props) {
    const [res, setRes] = useState<DiagnosisResponse | null>(null);
    const [error, setError] = useState<string | null>(null);
    const started = useRef(false);

    useEffect(() => {
        if (started.current) return;      // StrictMode double-effect would otherwise store the case twice
        started.current = true;
        DiagnosisService.diagnose({
            species: intake.species!,
            age_group: intake.ageGroup,
            breed_group: intake.breedGroup,
            audience: intake.audience,
            answers,
            initial,
            mode: intake.mode,
            top_k: 5,
            finalize: true,
            petName: intake.petName || undefined,
        }).then(setRes).catch((e) => setError(e.message || "خطا در دریافت نتیجه"));
    }, [intake, initial, answers]);

    if (error) return (
        <div className="text-center space-y-4 py-6">
            <p className="text-rose-300">{error}</p>
            <GlassButton variant="ghost" onClick={onBack}>بازگشت</GlassButton>
        </div>
    );
    if (!res) return <div className="py-10"><Spinner/><p className="text-center text-sm text-gray-400 mt-3">در حال محاسبهٔ نتیجه...</p></div>;

    const ag = res.agreement ? AGREEMENT_FA[res.agreement.state] : null;
    const showEngines = res.engine_used === "combined";
    const nc = res.non_cardiac;

    return (
        <div className="space-y-5 text-right" dir="rtl">
            <TriageBanner level={res.triage.level} messages={res.triage.messages}/>

            <section className="rounded-2xl border p-4" style={{borderColor: `${CARDIAC_COLOR[res.cardiac_likelihood.band]}66`}}>
                <div className="text-xs text-gray-400 mb-1">آیا مشکل از قلب است؟</div>
                <div className="font-semibold" style={{color: CARDIAC_COLOR[res.cardiac_likelihood.band]}}>
                    {CARDIAC_BAND_FA[res.cardiac_likelihood.band]}
                </div>
                {res.cardiac_likelihood.band !== "high" && nc.likely_causes.length > 0 && (
                    <div className="mt-3">
                        <div className="text-xs text-gray-400 mb-1">علل غیرقلبی محتمل</div>
                        <ul className="list-disc pr-5 text-sm text-gray-300 space-y-0.5">
                            {nc.likely_causes.slice(0, 3).map((c) => <li key={c.id}>{c.name_fa}</li>)}
                        </ul>
                    </div>
                )}
            </section>

            {ag && <div className="text-xs" style={{color: ag.c}}>● {ag.t}</div>}
            {res.warnings.filter((w) => w.code !== "engines_disagree").map((w) => (
                <p key={w.code} className="text-xs text-amber-300/90">⚠️ {w.fa}</p>
            ))}

            <section className="space-y-3">
                <h2 className="text-gray-200 font-semibold">فهرست تشخیص‌های افتراقی قلبی</h2>
                {res.ranking.map((d) => <DiseaseCard key={d.id} d={d} showEngines={showEngines}/>)}
            </section>

            <OutcomeForm caseId={res.case_id}/>

            <p className="text-xs text-gray-500 leading-relaxed border-t border-white/10 pt-3">{res.disclaimer_fa}</p>
            <p className="text-[11px] text-gray-600" dir="ltr">KB {res.kb_version} · engine: {res.engine_used}</p>

            <div className="flex gap-3 justify-between">
                <GlassButton onClick={onRestart}>شروع بیمار جدید</GlassButton>
                <GlassButton variant="ghost" onClick={onBack}>ادامهٔ پرسش‌ها</GlassButton>
            </div>
        </div>
    );
}

/** lets the vet record the confirmed diagnosis later -> real-world validation data */
function OutcomeForm({caseId}: { caseId?: string }) {
    const [diseases, setDiseases] = useState<KbDisease[]>([]);
    const [value, setValue] = useState("");
    const [note, setNote] = useState("");
    const [state, setState] = useState<"idle" | "saving" | "saved" | "error">("idle");

    useEffect(() => {
        if (caseId) DiagnosisService.getDiseases().then(setDiseases).catch(() => undefined);
    }, [caseId]);

    if (!caseId) return null;
    const save = async () => {
        setState("saving");
        try {
            await DiagnosisService.recordOutcome(caseId, value, note || undefined);
            setState("saved");
        } catch {
            setState("error");
        }
    };
    return (
        <details className="rounded-xl border border-white/10 bg-white/5 p-3">
            <summary className="cursor-pointer text-sm text-gray-300">ثبت تشخیص نهایی تأییدشده (برای ارزیابی دقت ابزار)</summary>
            <div className="mt-3 space-y-2">
                <select value={value} onChange={(e) => setValue(e.target.value)}
                        className="w-full bg-gray-900 border border-white/10 rounded-lg px-3 py-2 text-sm text-gray-100">
                    <option value="">انتخاب کنید...</option>
                    <option value="non_cardiac">علت غیرقلبی</option>
                    <option value="other">بیماری قلبی دیگر (خارج از فهرست)</option>
                    {diseases.map((d) => <option key={d.id} value={d.id}>{d.name_fa}</option>)}
                </select>
                <input value={note} onChange={(e) => setNote(e.target.value)} maxLength={2000} placeholder="توضیح (اختیاری): روش تأیید، اکو، ..."
                       className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-gray-100"/>
                <GlassButton onClick={save} disabled={!value || state === "saving" || state === "saved"}>
                    {state === "saved" ? "ثبت شد ✓" : "ثبت"}
                </GlassButton>
                {state === "error" && <p className="text-xs text-rose-300">ثبت انجام نشد.</p>}
            </div>
        </details>
    );
}
