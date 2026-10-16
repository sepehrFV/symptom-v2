// app/(dashboard)/diagnose/stepInterview.tsx  - adaptive one-question-at-a-time interview
"use client";

import {useCallback, useEffect, useRef, useState} from "react";
import DiagnosisService from "@/services/DiagnosisService";
import {Answer, DiagnosisResponse, Intake} from "@/types/diagnosis";
import {BandChip, GlassButton, Spinner, TriageBanner} from "@/app/(dashboard)/diagnose/ui";

type Props = {
    intake: Intake;
    initial: string[];
    answers: Record<string, Answer>;
    setAnswers: (a: Record<string, Answer>) => void;
    onFinish: () => void;
    onBack: () => void;
};

const MAX_QUESTIONS = 14;

export default function StepInterview({intake, initial, answers, setAnswers, onFinish, onBack}: Props) {
    const [res, setRes] = useState<DiagnosisResponse | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [history, setHistory] = useState<string[]>([]);
    const seq = useRef(0);

    const run = useCallback(async (ans: Record<string, Answer>) => {
        const my = ++seq.current;
        setLoading(true);
        setError(null);
        try {
            const r = await DiagnosisService.diagnose({
                species: intake.species!,
                age_group: intake.ageGroup,
                breed_group: intake.breedGroup,
                audience: intake.audience,
                answers: ans,
                initial,
                mode: intake.mode,
                top_k: 3,
            });
            if (my === seq.current) setRes(r);   // ignore out-of-order replies
        } catch (e: any) {
            if (my === seq.current) setError(e.message || "خطا در ارتباط با سرویس");
        } finally {
            if (my === seq.current) setLoading(false);
        }
    }, [intake, initial]);

    useEffect(() => {
        run(answers);
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    const answer = (a: Answer) => {
        const q = res?.next_question;
        if (!q || loading) return;
        const next = {...answers, [q.id]: a};
        setAnswers(next);
        setHistory((h) => [...h, q.id]);
        run(next);
    };

    const undo = () => {
        if (loading) return;
        if (!history.length) return onBack();
        const last = history[history.length - 1];
        const {[last]: _removed, ...rest} = answers;
        setAnswers(rest);
        setHistory((h) => h.slice(0, -1));
        run(rest);
    };

    const q = res?.next_question;
    const asked = res?.status.adaptive_asked ?? history.length;
    const done = res?.status.done ?? false;
    const canFinish = !!res && (res.status.can_conclude || done);
    const text = (intake.audience === "clinician" ? q?.text_fa : q?.text_fa) ?? "";

    return (
        <div className="space-y-5 text-right" dir="rtl">
            {res && <TriageBanner level={res.triage.level} messages={res.triage.messages}/>}

            <div className="flex items-center justify-between text-xs text-gray-400">
                <span>سؤال {Math.min(asked + 1, MAX_QUESTIONS)} (حداکثر {MAX_QUESTIONS})</span>
                <span>{res?.status.answered ?? 0} پاسخ ثبت شده</span>
            </div>
            <div className="h-1.5 rounded-full bg-white/10 overflow-hidden">
                <div className="h-full bg-gradient-to-r from-blue-500 to-indigo-500 transition-all" style={{width: `${Math.min(100, (asked / MAX_QUESTIONS) * 100)}%`}}/>
            </div>

            <div className="rounded-2xl border border-white/10 bg-black/30 p-5 min-h-[200px] flex flex-col justify-center">
                {error && (
                    <div className="text-center space-y-3">
                        <p className="text-rose-300 text-sm">{error}</p>
                        <GlassButton onClick={() => run(answers)}>تلاش دوباره</GlassButton>
                    </div>
                )}
                {!error && loading && !res && <Spinner/>}
                {!error && res && !done && q && (
                    <div className={loading ? "opacity-60 pointer-events-none" : ""}>
                        <div className="text-xs text-blue-300/80 mb-2">{q.label_fa}</div>
                        <p className="text-lg text-gray-100 leading-relaxed">{text}</p>
                        {q.hint_fa && <p className="text-xs text-gray-400 mt-2 leading-relaxed">💡 {q.hint_fa}</p>}
                        <div className="grid grid-cols-3 gap-3 mt-5">
                            <GlassButton variant="yes" onClick={() => answer("yes")}>بله</GlassButton>
                            <GlassButton variant="no" onClick={() => answer("no")}>خیر</GlassButton>
                            <GlassButton variant="ghost" onClick={() => answer("unknown")}>نمی‌دانم</GlassButton>
                        </div>
                    </div>
                )}
                {!error && res && (done || !q) && (
                    <div className="text-center">
                        <p className="text-emerald-300 font-medium">پرسش‌ها کافی است</p>
                        <p className="text-sm text-gray-400 mt-1">برای مشاهدهٔ نتیجهٔ کامل ادامه دهید.</p>
                    </div>
                )}
            </div>

            {res && (
                <div className="rounded-xl border border-white/10 bg-white/5 p-3">
                    <div className="text-xs text-gray-400 mb-2">برآورد فعلی (با هر پاسخ تغییر می‌کند)</div>
                    <ul className="space-y-1.5">
                        {res.ranking.slice(0, 3).map((r) => (
                            <li key={r.id} className="flex items-center justify-between gap-2 text-sm text-gray-200">
                                <span>{r.rank}. {r.name_fa}</span>
                                <BandChip band={r.band}/>
                            </li>
                        ))}
                    </ul>
                    {res.warnings.some((w) => w.code === "few_answers") && (
                        <p className="text-xs text-amber-300/80 mt-2">تعداد پاسخ‌ها هنوز کم است.</p>
                    )}
                </div>
            )}

            <div className="flex gap-3 justify-between">
                <GlassButton onClick={onFinish} disabled={!canFinish || loading} variant={done ? "primary" : "ghost"}>
                    {done ? "مشاهدهٔ نتیجه" : "نمایش نتیجهٔ فعلی"}
                </GlassButton>
                <GlassButton variant="ghost" onClick={undo} disabled={loading}>
                    {history.length ? "بازگشت به پاسخ قبل" : "بازگشت"}
                </GlassButton>
            </div>
            {!canFinish && res && <p className="text-xs text-gray-500">برای نمایش نتیجه حداقل ۳ پاسخ لازم است.</p>}
        </div>
    );
}
