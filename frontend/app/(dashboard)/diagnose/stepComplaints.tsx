// app/(dashboard)/diagnose/stepComplaints.tsx
"use client";

import {useEffect, useMemo, useState} from "react";
import DiagnoseStepContainer from "@/app/(dashboard)/diagnose/DiagnoseStepContainer";
import DiagnosisService from "@/services/DiagnosisService";
import {Intake, SignInfo} from "@/types/diagnosis";
import {Spinner} from "@/app/(dashboard)/diagnose/ui";

type Props = {
    intake: Intake;
    signs: SignInfo[];
    setSigns: (s: SignInfo[]) => void;
    selected: string[];
    setSelected: (ids: string[]) => void;
    onNext: () => void;
    onBack: () => void;
};

export default function StepComplaints({intake, signs, setSigns, selected, setSelected, onNext, onBack}: Props) {
    const [loading, setLoading] = useState(signs.length === 0);
    const [error, setError] = useState<string | null>(null);
    const [q, setQ] = useState("");

    useEffect(() => {
        if (signs.length) return;
        DiagnosisService.getSigns(intake.audience)
            .then((s) => setSigns(s))
            .catch((e) => setError(e.message))
            .finally(() => setLoading(false));
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    const groups = useMemo(() => {
        const term = q.trim().toLowerCase();
        const map = new Map<string, SignInfo[]>();
        signs
            .filter((s) => !term || s.label_fa.includes(q.trim()) || s.label_en.toLowerCase().includes(term))
            .forEach((s) => {
                const arr = map.get(s.group_fa) ?? [];
                arr.push(s);
                map.set(s.group_fa, arr);
            });
        return Array.from(map.entries());
    }, [signs, q]);

    const toggle = (id: string) => setSelected(selected.includes(id) ? selected.filter((x) => x !== id) : [...selected, id]);

    return (
        <DiagnoseStepContainer
            currentStep={3}
            totalSteps={5}
            title="شکایت و یافته‌های اصلی"
            subtitle="هر مورد را که الان وجود دارد انتخاب کنید. دربارهٔ بقیه در مرحلهٔ بعد پرسیده می‌شود."
            onContinue={onNext}
            onBack={onBack}
            canContinue={selected.length >= 1}
            continueText={selected.length ? `ادامه (${selected.length} مورد انتخاب شد)` : "حداقل یک مورد انتخاب کنید"}
        >
            <div className="p-5 text-right space-y-4" dir="rtl">
                <input
                    value={q}
                    onChange={(e) => setQ(e.target.value)}
                    placeholder="جستجوی علامت..."
                    className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2.5 text-gray-100 text-sm focus:outline-none focus:ring-1 focus:ring-blue-500/50"
                />
                {loading && <Spinner/>}
                {error && <p className="text-rose-300 text-sm">{error}</p>}
                {groups.map(([group, items]) => (
                    <section key={group}>
                        <h3 className="text-xs text-gray-400 mb-2">{group}</h3>
                        <div className="flex flex-wrap gap-2">
                            {items.map((s) => {
                                const on = selected.includes(s.id);
                                return (
                                    <button key={s.id} type="button" onClick={() => toggle(s.id)} title={s.hint_fa || s.text_fa}
                                            className={`px-3 py-1.5 rounded-full text-sm border transition ${on
                                                ? "bg-blue-500/25 border-blue-400 text-white" : "bg-white/5 border-white/10 text-gray-300 hover:bg-white/10"}`}>
                                        {on ? "✓ " : ""}{s.label_fa}
                                    </button>
                                );
                            })}
                        </div>
                    </section>
                ))}
            </div>
        </DiagnoseStepContainer>
    );
}
