// context/ActiveTimeContext.tsx
"use client";
import React, { createContext, useContext, useEffect, useRef, useState } from "react";

const ActiveTimeContext = createContext<{ activeMinutes: number }>({ activeMinutes: 0 });

export function ActiveTimeProvider({ children }: { children: React.ReactNode }) {
    const [activeSeconds, setActiveSeconds] = useState(0);
    const intervalRef = useRef<NodeJS.Timeout | null>(null);

    useEffect(() => {
        const saved = localStorage.getItem("activeTime");
        if (saved) {
            setActiveSeconds(parseInt(saved, 10));
        }
    }, []);

    useEffect(() => {
        const handleVisibilityChange = () => {
            const isVisible = document.visibilityState === "visible" && document.hasFocus();

            if (isVisible && intervalRef.current === null) {
                intervalRef.current = setInterval(() => {
                    setActiveSeconds((prev) => {
                        const updated = prev + 1;
                        localStorage.setItem("activeTime", updated.toString());
                        return updated;
                    });
                }, 1000);
            } else if (!isVisible && intervalRef.current) {
                clearInterval(intervalRef.current);
                intervalRef.current = null;
            }
        };

        handleVisibilityChange(); // on mount
        document.addEventListener("visibilitychange", handleVisibilityChange);
        window.addEventListener("focus", handleVisibilityChange);
        window.addEventListener("blur", handleVisibilityChange);

        return () => {
            clearInterval(intervalRef.current!);
            document.removeEventListener("visibilitychange", handleVisibilityChange);
            window.removeEventListener("focus", handleVisibilityChange);
            window.removeEventListener("blur", handleVisibilityChange);
        };
    }, []);

    const activeMinutes = Math.floor(activeSeconds / 60);

    return (
        <ActiveTimeContext.Provider value={{ activeMinutes }}>
            {children}
        </ActiveTimeContext.Provider>
    );
}

export function useActiveTime() {
    return useContext(ActiveTimeContext);
}
