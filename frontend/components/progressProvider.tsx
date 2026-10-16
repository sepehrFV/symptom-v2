'use client';
import {AppProgressProvider as ProgressProvider} from '@bprogress/next';

const Providers = ({children}: { children: React.ReactNode }) => {
    return (
        <ProgressProvider
            height="6px"
            color="#1546d6"
            options={{showSpinner: false}}
        >
            {children}
        </ProgressProvider>
    );
};

export default Providers;