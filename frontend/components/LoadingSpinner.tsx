import { Loader2 } from "lucide-react";

interface LoadingSpinnerProps {
  message?: string;
}

export default function LoadingSpinner({
  message = "Loading...",
}: LoadingSpinnerProps) {
  return (
    <div className="flex flex-col items-center justify-center p-8 w-full min-h-[300px]">
      <Loader2 className="h-12 w-12 animate-spin text-yellow-500 mb-4" />
      <p className="text-lg font-semibold text-gray-700">{message}</p>
    </div>
  );
}


