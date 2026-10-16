// app/(dashboard)/diagnose/stepPatientInfo.tsx
"use client";

import DiagnoseStepContainer from "@/app/(dashboard)/diagnose/DiagnoseStepContainer";
import {Intake, MetaResponse, EngineMode, Audience, AgeGroupId} from "@/types/diagnosis";

type Props = {
    meta: MetaResponse | null;
    intake: Intake;
    setIntake: React.Dispatch<React.SetStateAction<Intake>>;
    onNext: () => void;
    onBack: () => void;
};

const FIELD = "w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-right text-gray-100 focus:outline-none focus:ring-1 focus:ring-blue-500/50";

const MODES: { id: EngineMode; label: string; hint: string }[] = [
    {id: "combined", label: "ترکیبی (پیشنهادی)", hint: "میانگین دو موتور + نمایش توافق یا اختلاف آن‌ها"},
    {id: "rule", label: "فقط قاعده‌محور", hint: "مدل بیزی شفاف بر پایهٔ دانش پایگاه"},
    {id: "ai", label: "فقط هوش مصنوعی", hint: "شبکهٔ عصبی آموزش‌دیده روی موارد شبیه‌سازی‌شده"},
];

export default function StepPatientInfo({meta, intake, setIntake, onNext, onBack}: Props) {
    const set = <K extends keyof Intake>(k: K, v: Intake[K]) => setIntake((p) => ({...p, [k]: v}));
    const breeds = meta && intake.species ? meta.breed_groups[intake.species] : [];
    const speciesFa = intake.species === "cat" ? "گربه" : "سگ";

    return (
        <DiagnoseStepContainer
            currentStep={2}
            totalSteps={5}
            title="مشخصات بیمار"
            subtitle={`اطلاعات ${speciesFa} را وارد کنید — سن و نژاد شیوع بیماری‌ها را تغییر می‌دهند`}
            onContinue={onNext}
            onBack={onBack}
            canContinue={!!meta}
            continueText="ادامه به علائم"
        >
            <div className="w-full space-y-5 p-5 text-right" dir="rtl">
                <div>
                    <label className="block text-sm text-gray-200 mb-2">نام حیوان <span className="text-xs text-gray-500">(اختیاری)</span></label>
                    <input className={FIELD} value={intake.petName} maxLength={100} onChange={(e) => set("petName", e.target.value)} placeholder="مثلاً: لونا"/>
                </div>

                <div>
                    <label className="block text-sm text-gray-200 mb-2">گروه سنی</label>
                    <div className="grid grid-cols-3 gap-2">
                        {(meta?.age_groups ?? []).map((a) => (
                            <button key={a.id} type="button" onClick={() => set("ageGroup", a.id as AgeGroupId)}
                                    className={`rounded-xl px-2 py-3 text-sm border transition ${intake.ageGroup === a.id
                                        ? "border-blue-400 bg-blue-500/20 text-white" : "border-white/10 bg-white/5 text-gray-300 hover:bg-white/10"}`}>
                                {a.label_fa}
                            </button>
                        ))}
                    </div>
                    {!intake.ageGroup && <p className="text-xs text-amber-300/80 mt-2">اگر سن را وارد نکنید، از شیوع‌های عمومی استفاده می‌شود و دقت کمتر است.</p>}
                </div>

                <div>
                    <label className="block text-sm text-gray-200 mb-2">نژاد / گروه جثه</label>
                    <select className={FIELD} value={intake.breedGroup} onChange={(e) => set("breedGroup", e.target.value)}>
                        {breeds.map((b) => <option key={b.id} value={b.id} className="bg-gray-900">{b.label_fa}</option>)}
                    </select>
                </div>

                <div>
                    <label className="block text-sm text-gray-200 mb-2">چه کسی به پرسش‌ها پاسخ می‌دهد؟</label>
                    <div className="grid grid-cols-2 gap-2">
                        {([["owner", "صاحب حیوان", "فقط مشاهدات و سوابق"], ["clinician", "دامپزشک / دانشجو", "شامل معاینه، ECG، اکو و آزمایش"]] as [Audience, string, string][]).map(([id, label, hint]) => (
                            <button key={id} type="button" onClick={() => set("audience", id)}
                                    className={`rounded-xl px-3 py-3 text-sm border text-right transition ${intake.audience === id
                                        ? "border-blue-400 bg-blue-500/20 text-white" : "border-white/10 bg-white/5 text-gray-300 hover:bg-white/10"}`}>
                                <div className="font-medium">{label}</div>
                                <div className="text-xs text-gray-400 mt-0.5">{hint}</div>
                            </button>
                        ))}
                    </div>
                </div>

                <details className="rounded-xl border border-white/10 bg-white/5 p-3">
                    <summary className="cursor-pointer text-sm text-gray-300">تنظیمات پیشرفته: موتور تشخیص</summary>
                    <div className="mt-3 space-y-2">
                        {MODES.map((m) => (
                            <label key={m.id} className="flex items-start gap-3 text-sm text-gray-200 cursor-pointer">
                                <input type="radio" name="mode" checked={intake.mode === m.id} onChange={() => set("mode", m.id)} className="mt-1"/>
                                <span>{m.label}<span className="block text-xs text-gray-500">{m.hint}</span></span>
                            </label>
                        ))}
                    </div>
                </details>
            </div>
        </DiagnoseStepContainer>
    );
}
