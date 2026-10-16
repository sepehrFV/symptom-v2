import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@shared/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all duration-150 active:scale-[0.97] disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive",
  {
    variants: {
      variant: {
        default:
          "bg-yellow-500 text-primary-background shadow-xs hover:bg-yellow-400",
        destructive:
          "bg-destructive text-white shadow-xs hover:bg-destructive/90 focus-visible:ring-destructive/20 dark:focus-visible:ring-destructive/40 dark:bg-destructive/60",
        outline:
          "border bg-background shadow-xs hover:bg-accent hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50",
        secondary:
          "bg-secondary text-secondary-foreground shadow-xs hover:bg-secondary/80",
       tertiary:
          "bg-primary text-primary-foreground shadow-xs hover:bg-primary/90",
        ghost:
          "hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50",
        link: "text-primary underline-offset-4 hover:underline",

        // Enya Custom Variants
        enya_neutral: "rounded-xl border-2 border-[hsl(var(--button-neutral-border))] bg-[hsl(var(--button-neutral))] text-[hsl(var(--button-neutral-text))] font-bold shadow-[0_4px_0_0_hsl(var(--button-neutral-shadow))] active:shadow-none active:translate-y-[4px] motion-reduce:hover:transform-none motion-reduce:active:transform-none focus-visible:ring-2 focus-visible:ring-[hsl(var(--button-selected-border))] focus-visible:ring-offset-2 disabled:shadow-[0_4px_0_0_hsl(var(--button-neutral-shadow))] disabled:opacity-50 disabled:hover:translate-y-0",
        enya_secondary: "rounded-[12px] border-2 border-[hsl(var(--button-secondary-border))] bg-[hsl(var(--button-secondary))] text-[hsl(var(--button-secondary-text))] font-bold shadow-[0_4px_0_0_hsl(var(--button-secondary-shadow))] active:shadow-none active:translate-y-[4px] motion-reduce:hover:transform-none motion-reduce:active:transform-none focus-visible:ring-2 focus-visible:ring-[hsl(var(--button-selected-border))] focus-visible:ring-offset-2 disabled:shadow-[0_4px_0_0_hsl(var(--button-secondary-shadow))] disabled:opacity-50 disabled:hover:translate-y-0",
        enya_primary: "rounded-xl border-2 border-[hsl(var(--button-primary-border))] bg-[hsl(var(--button-primary))] text-[hsl(var(--button-primary-text))] font-bold shadow-[0_4px_0_0_hsl(var(--button-primary-shadow))] active:shadow-none active:translate-y-[4px] motion-reduce:hover:transform-none motion-reduce:active:transform-none focus-visible:ring-2 focus-visible:ring-[hsl(var(--button-selected-border))] focus-visible:ring-offset-2 disabled:shadow-[0_4px_0_0_hsl(var(--button-primary-shadow))] disabled:opacity-50 disabled:hover:translate-y-0",
        enya_success: "rounded-xl border-2 border-[hsl(var(--button-success-border))] bg-[hsl(var(--button-success))] text-[hsl(var(--button-success-text))] font-bold shadow-[0_4px_0_0_hsl(var(--button-success-shadow))] active:shadow-none active:translate-y-[4px] motion-reduce:hover:transform-none motion-reduce:active:transform-none focus-visible:ring-2 focus-visible:ring-[hsl(var(--button-selected-border))] focus-visible:ring-offset-2 disabled:shadow-[0_4px_0_0_hsl(var(--button-success-shadow))] disabled:opacity-50 disabled:hover:translate-y-0",
        enya_error: "rounded-xl border-2 border-[hsl(var(--button-error-border))] bg-[hsl(var(--button-error))] text-[hsl(var(--button-error-text))] font-bold shadow-[0_4px_0_0_hsl(var(--button-error-shadow))] active:shadow-none active:translate-y-[4px] motion-reduce:hover:transform-none motion-reduce:active:transform-none focus-visible:ring-2 focus-visible:ring-[hsl(var(--button-selected-border))] focus-visible:ring-offset-2 disabled:shadow-[0_4px_0_0_hsl(var(--button-error-shadow))] disabled:opacity-50 disabled:hover:translate-y-0",
      },  
      size: {
        default: "h-9 px-4 py-2 has-[>svg]:px-3",
        sm: "h-8 rounded-xl gap-1.5 px-3 has-[>svg]:px-2.5",
        lg: "h-11 rounded-xl px-6 has-[>svg]:px-4",
        icon: "size-9",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
);

function Button({
  className,
  variant,
  size,
  children,
  asChild = false,
  ...props
}: React.ComponentProps<"button"> &
  VariantProps<typeof buttonVariants> & {
    asChild?: boolean;
  }) {
  const Comp = asChild ? Slot : "button";

  return (
    <Comp
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    >
      {children}
    </Comp>
  );
}

export { Button, buttonVariants };
