// Small shared presentational helpers of the diagnosis flow (Persian labels for engine enums)
"use client";

import React from "react";
import {Band, CardiacBand, Urgency} from "@/types/diagnosis";

export const BAND_FA: Record<Band, string> = {
    high: "احتمال بالا",
    moderate: "احتمال متوسط",
    low: "احتمال کم",
    unlikely: "بعید",
};

export const CARDIAC_BAND_FA: Record<CardiacBand, string> = {
    high: "علت قلبی بسیار محتمل است",
    moderate: "علت قلبی محتمل است",
    low: "علت قلبی کمتر محتمل است",
    very_low: "علت قلبی بعید است",
};

export const URGENCY_FA: Record<Urgency, string> = {
    routine: "عادی",
    urgent: "فوری (ظرف ۲۴ ساعت)",
    emergency: "اورژانس",
};

export const BAND_COLOR: Record<Band, string> = {
    high: "#34d399",
    moderate: "#fbbf24",
    low: "#fb923c",
    unlikely: "#94a3b8",
};

export const CARDIAC_COLOR: Record<CardiacBand, string> = {
    high: "#f87171",
    moderate: "#fbbf24",
    low: "#60a5fa",
    very_low: "#94a3b8",
};

export function bandOfScore(p: number | null | undefined): Band | null {
    if (p === null || p === undefined) return null;
    // same thresholds as kb/settings.yaml -> decision.bands
    if (p >= 0.6) return "high";
    if (p >= 0.25) return "moderate";
    if (p >= 0.08) return "low";
    return "unlikely";
}

export function BandChip({band}: { band: Band }) {
    const c = BAND_COLOR[band];
    return (
        <span
            className="inline-block px-2.5 py-0.5 rounded-full text-xs font-medium border"
            style={{color: c, borderColor: `${c}66`, background: `${c}1a`}}
        >
            {BAND_FA[band]}
        </span>
    );
}

export function ScoreBar({value, label}: { value: number | null; label: string }) {
    if (value === null || value === undefined) return null;
    const band = bandOfScore(value)!;
    return (
        <div className="flex items-center gap-2 text-xs text-gray-400">
            <span className="w-20 shrink-0">{label}</span>
            <div className="flex-1 h-1.5 rounded-full bg-white/10 overflow-hidden">
                <div className="h-full rounded-full" style={{width: `${Math.max(2, value * 100)}%`, background: BAND_COLOR[band]}}/>
            </div>
            <span className="w-16 text-left" style={{color: BAND_COLOR[band]}}>{BAND_FA[band]}</span>
        </div>
    );
}

export function TriageBanner({level, messages}: { level: Urgency; messages: { fa: string }[] }) {
    if (level === "routine") return null;
    const emergency = level === "emergency";
    const color = emergency ? "#f87171" : "#fbbf24";
    return (
        <div className="rounded-xl p-4 text-right border" style={{borderColor: `${color}80`, background: `${color}14`}} role="alert">
            <div className="font-bold mb-1" style={{color}}>
                {emergency ? "⚠️ وضعیت اورژانسی — بلافاصله به دامپزشک مراجعه کنید" : "⚠️ نیاز به ارزیابی دامپزشکی ظرف ۲۴ ساعت"}
            </div>
            <ul className="text-sm text-gray-200 space-y-1 list-disc pr-5">
                {messages.slice(0, 4).map((m, i) => <li key={i}>{m.fa}</li>)}
            </ul>
        </div>
    );
}

export function GlassButton({children, onClick, disabled, variant = "primary", className = ""}: {
    children: React.ReactNode; onClick?: () => void; disabled?: boolean; variant?: "primary" | "ghost" | "yes" | "no"; className?: string;
}) {
    const base = "px-5 py-3 rounded-xl font-semibold transition-all active:scale-[0.98] disabled:opacity-50 disabled:cursor-not-allowed";
    const styles: Record<string, string> = {
        primary: "text-white bg-gradient-to-r from-blue-500 to-indigo-500 hover:shadow-lg",
        ghost: "text-gray-200 border border-white/10 bg-white/5 hover:bg-white/10",
        yes: "text-emerald-200 border border-emerald-500/40 bg-emerald-500/10 hover:bg-emerald-500/20",
        no: "text-rose-200 border border-rose-500/40 bg-rose-500/10 hover:bg-rose-500/20",
    };
    return <button type="button" onClick={onClick} disabled={disabled} className={`${base} ${styles[variant]} ${className}`}>{children}</button>;
}

export function Spinner() {
    return <div className="w-6 h-6 rounded-full border-2 border-white/20 border-t-blue-400 animate-spin mx-auto"/>;
}
