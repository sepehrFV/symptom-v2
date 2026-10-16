// app/(dashboard)/diseases/page.tsx
"use client";

import { useEffect, useState, useMemo } from "react";
import { useBreadcrumbs } from "@/context/BreadcrumbContext";
import { Button } from "@shared/components/ui/button";
import { Input } from "@shared/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@shared/components/ui/select";
import { Badge } from "@shared/components/ui/badge";
import { Skeleton } from "@shared/components/ui/skeleton";
import { ArrowUpDown, Filter, MoreVertical, Search } from "lucide-react";
import { useRouter } from "next/navigation";
import { Disease } from "@/types/model/Disease";

// Enums
import { SpeciesEnum } from "@/types/enum/SpeciesEnum";
import { DiseaseTypeEnum, DiseaseTypeEnumType } from "@/types/enum/DiseaseTypeEnum";
import { SymptomEnum, SymptomKey } from "@/types/enum/SymptomEnum";
import { DiagnosticMethodEnum, DiagnosticMethodEnumType } from "@/types/enum/DiagnosticMethodEnum";
import { TreatmentTypeEnum, TreatmentTypeEnumType } from "@/types/enum/TreatmentTypeEnum";

import diseaseService from "@/services/DiseaseService";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@shared/components/ui/table";
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
  DropdownMenuLabel,
  DropdownMenuSeparator,
} from "@shared/components/ui/dropdown-menu";
import { truncateText } from "@/utils/text";

// Theme imports
import { COLORS, GRADIENTS, STYLES } from "@/lib/theme";
import '@fontsource/vazir/400.css';
import '@fontsource/vazir/500.css';

export default function DiseaseLibrary() {
  const router = useRouter();
  const { setBreadcrumbs } = useBreadcrumbs();

  const [diseases, setDiseases] = useState<Disease[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [mounted, setMounted] = useState(false);

  useEffect(() => { setMounted(true); }, []);

  // Breadcrumbs
  useEffect(() => {
    setBreadcrumbs([
      { label: "خانه", href: "/" },
      { label: "کتابخانه بیماری‌ها", href: "/diseases" },
    ]);
  }, [setBreadcrumbs]);

  // Fetch data
  useEffect(() => {
    const fetchDiseases = async () => {
      try {
        const data = await diseaseService.getAllDiseases();
        setDiseases(data);
      } catch (error) {
        console.error("Error fetching diseases:", error);
      } finally {
        setIsLoading(false);
      }
    };
    fetchDiseases();
  }, []);

  // Filters
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedType, setSelectedType] = useState<DiseaseTypeEnumType | "all">("all");
  const [selectedSpecies, setSelectedSpecies] = useState<string[]>([]);
  const [selectedDiagnosisMethods, setSelectedDiagnosisMethods] = useState<DiagnosticMethodEnumType[]>([]);
  const [selectedTreatmentTypes, setSelectedTreatmentTypes] = useState<TreatmentTypeEnumType[]>([]);
  const [selectedSymptoms, setSelectedSymptoms] = useState<SymptomKey[]>([]);

  // Sorting
  const [sortConfig, setSortConfig] = useState<{
    key: keyof Disease;
    direction: "asc" | "desc";
  } | null>(null);

  const filteredDiseases = useMemo(() => {
    return diseases.filter((disease) => {
      // Search
      const matchesSearch =
          disease.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
          disease.per_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
          (disease.description && disease.description.toLowerCase().includes(searchTerm.toLowerCase())) ||
          (disease.per_description && disease.per_description.toLowerCase().includes(searchTerm.toLowerCase()));

      // Type (single)
      const matchesType = selectedType === "all" || disease.type === selectedType;

      // Species (multi)
      const matchesSpecies =
          selectedSpecies.length === 0 ||
          (disease.affected_species?.some(species => selectedSpecies.includes(species)));

      // Diagnosis (multi)
      const matchesDiagnosis =
          selectedDiagnosisMethods.length === 0 ||
          (disease.diagnoses?.some(d => selectedDiagnosisMethods.includes(d.type)));

      // Treatment (multi)
      const matchesTreatment =
          selectedTreatmentTypes.length === 0 ||
          (disease.treatments?.some(t => selectedTreatmentTypes.includes(t.type)));

      // Symptom (multi)
      const matchesSymptom =
          selectedSymptoms.length === 0 ||
          selectedSymptoms.includes(disease.mainSymptom as SymptomKey) ||
          (disease.symptoms?.some(symptom => selectedSymptoms.includes(symptom)));

      return matchesSearch && matchesType && matchesSpecies && matchesDiagnosis && matchesTreatment && matchesSymptom;
    }).sort((a, b) => {
      if (!sortConfig) return 0;

      let aValue: any = a[sortConfig.key];
      let bValue: any = b[sortConfig.key];

      if (sortConfig.key === "name") {
        aValue = aValue?.toLowerCase() || "";
        bValue = bValue?.toLowerCase() || "";
      }

      if (aValue < bValue) return sortConfig.direction === "asc" ? -1 : 1;
      if (aValue > bValue) return sortConfig.direction === "asc" ? 1 : -1;
      return 0;
    });
  }, [diseases, searchTerm, selectedType, selectedSpecies, selectedDiagnosisMethods, selectedTreatmentTypes, selectedSymptoms, sortConfig]);

  const handleSort = (key: keyof Disease) => {
    setSortConfig((prev) =>
        prev?.key === key && prev.direction === "asc"
            ? { key, direction: "desc" }
            : { key, direction: "asc" }
    );
  };

  const handleViewDisease = (disease: Disease) => {
    router.push(`/diseases/view/${disease.id}`);
  };

  const toggleSpecies = (species: string) => {
    setSelectedSpecies(prev =>
        prev.includes(species)
            ? prev.filter(s => s !== species)
            : [...prev, species]
    );
  };

  const toggleDiagnosis = (method: DiagnosticMethodEnumType) => {
    setSelectedDiagnosisMethods(prev =>
        prev.includes(method)
            ? prev.filter(m => m !== method)
            : [...prev, method]
    );
  };

  const toggleTreatment = (type: TreatmentTypeEnumType) => {
    setSelectedTreatmentTypes(prev =>
        prev.includes(type)
            ? prev.filter(t => t !== type)
            : [...prev, type]
    );
  };

  const toggleSymptom = (symptom: SymptomKey) => {
    setSelectedSymptoms(prev =>
        prev.includes(symptom)
            ? prev.filter(s => s !== symptom)
            : [...prev, symptom]
    );
  };

  const clearAllFilters = () => {
    setSelectedType("all");
    setSelectedSpecies([]);
    setSelectedDiagnosisMethods([]);
    setSelectedTreatmentTypes([]);
    setSelectedSymptoms([]);
    setSearchTerm("");
  };

  // Loading skeleton
  if (isLoading) {
    return (
        <div
            className="min-h-screen relative overflow-hidden"
            style={{ background: `radial-gradient(circle at 30% 30%, ${COLORS.primary}10, transparent 70%), #000` }}
        >
          <div className="absolute inset-0 opacity-5">
            <div className="absolute top-1/4 left-1/3 w-96 h-96 bg-blue-500 rounded-full blur-[120px] animate-pulse"></div>
          </div>

          <div className="max-w-7xl mx-auto px-4 py-8">
            <div className="flex flex-col lg:items-center lg:flex-row gap-5 mb-6">
              <Skeleton className="h-12 w-full sm:max-w-3xl rounded-xl" />
              <div className="flex flex-wrap items-center gap-3">
                {[...Array(5)].map((_, i) => (
                    <Skeleton key={i} className="h-10 w-32 rounded-xl" />
                ))}
              </div>
            </div>

            <div
                className="rounded-2xl overflow-hidden border border-white/10"
                style={{
                  ...STYLES.glassPanel,
                  boxShadow: "0 20px 40px -15px rgba(0, 0, 0, 0.6)"
                }}
            >
              <div className="p-6">
                <div className="flex items-center gap-4 pb-4 border-b border-white/10 mb-4">
                  {[...Array(6)].map((_, i) => (
                      <Skeleton key={i} className="h-5 w-24 rounded" />
                  ))}
                </div>
                {[...Array(8)].map((_, i) => (
                    <div key={i} className="flex items-center gap-4 py-4 border-b border-white/5 last:border-0">
                      <Skeleton className="h-5 w-8 rounded" />
                      <div className="flex-1 space-y-2">
                        <Skeleton className="h-4 w-3/4 rounded" />
                        <Skeleton className="h-3 w-1/2 rounded" />
                      </div>
                      {[...Array(4)].map((_, j) => (
                          <Skeleton key={j} className="h-4 w-16 rounded" />
                      ))}
                    </div>
                ))}
              </div>
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
        {/* Background glow */}
        <div className="absolute top-1/4 left-1/4 w-80 h-80 bg-blue-500 rounded-full blur-[120px] opacity-10 animate-pulse"></div>
        <div className="absolute bottom-1/3 right-1/3 w-72 h-72 bg-indigo-600 rounded-full blur-[100px] opacity-5 animate-pulse delay-700"></div>

        <div className="max-w-7xl mx-auto px-4 py-6">
          {/* Filters Row */}
          <div className="flex flex-col lg:items-center lg:flex-row gap-5 mb-6">
            {/* Search */}
            <div className="flex-1">
              <div className="relative sm:max-w-3xl">
                <Search
                    className="absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5"
                />
                <Input
                    placeholder="جستجو بر اساس نام یا توضیحات بیماری..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="pl-12 pr-4 py-3 bg-white/5 border-white/10 text-gray-100 placeholder-gray-500 rounded-xl
                          focus:ring-0 focus:border-blue-500/50 focus:outline-none
                          backdrop-blur-xl"
                    style={{
                      WebkitBackdropFilter: "blur(12px)",
                      backdropFilter: "blur(12px)",
                    }}
                />
              </div>
            </div>

            {/* Filter Controls */}
            <div className="flex flex-wrap items-center gap-3">
              {[
                {
                  label: "نوع عارضه",
                  value: selectedType !== "all" ? 1 : 0,
                  onClick: () => {},
                  content: (
                      <>
                        <DropdownMenuLabel>انواع عارضه</DropdownMenuLabel>
                        <DropdownMenuSeparator className="bg-white/10" />
                        <DropdownMenuCheckboxItem
                            checked={selectedType === "all"}
                            onCheckedChange={() => setSelectedType("all")}
                            className="text-gray-200"
                        >
                          همه
                        </DropdownMenuCheckboxItem>
                        {Object.entries(DiseaseTypeEnum).map(([key, meta]) => (
                            <DropdownMenuCheckboxItem
                                key={key}
                                checked={selectedType === key}
                                onCheckedChange={() => setSelectedType(key as DiseaseTypeEnumType)}
                                className="text-gray-200"
                            >
                              {meta.label}
                            </DropdownMenuCheckboxItem>
                        ))}
                      </>
                  )
                },
                {
                  label: "گونه جانوری",
                  value: selectedSpecies.length,
                  onClick: toggleSpecies,
                  content: (
                      <>
                        <DropdownMenuLabel>گونه‌ها</DropdownMenuLabel>
                        <DropdownMenuSeparator className="bg-white/10" />
                        {Object.entries(SpeciesEnum).map(([key, meta]) => (
                            <DropdownMenuCheckboxItem
                                key={key}
                                checked={selectedSpecies.includes(key)}
                                onCheckedChange={() => toggleSpecies(key)}
                                className="text-gray-200"
                            >
                              {meta.label}
                            </DropdownMenuCheckboxItem>
                        ))}
                      </>
                  )
                },
                {
                  label: "روش تشخیص",
                  value: selectedDiagnosisMethods.length,
                  onClick: toggleDiagnosis,
                  content: (
                      <>
                        <DropdownMenuLabel>متودهای تشخیصی</DropdownMenuLabel>
                        <DropdownMenuSeparator className="bg-white/10" />
                        {Object.entries(DiagnosticMethodEnum).map(([key, meta]) => (
                            <DropdownMenuCheckboxItem
                                key={key}
                                checked={selectedDiagnosisMethods.includes(key as DiagnosticMethodEnumType)}
                                onCheckedChange={() => toggleDiagnosis(key as DiagnosticMethodEnumType)}
                                className="text-gray-200"
                            >
                              {meta.label}
                            </DropdownMenuCheckboxItem>
                        ))}
                      </>
                  )
                },
                {
                  label: "درمان",
                  value: selectedTreatmentTypes.length,
                  onClick: toggleTreatment,
                  content: (
                      <>
                        <DropdownMenuLabel>انواع درمان‌ها</DropdownMenuLabel>
                        <DropdownMenuSeparator className="bg-white/10" />
                        {Object.entries(TreatmentTypeEnum).map(([key, meta]) => (
                            <DropdownMenuCheckboxItem
                                key={key}
                                checked={selectedTreatmentTypes.includes(key as TreatmentTypeEnumType)}
                                onCheckedChange={() => toggleTreatment(key as TreatmentTypeEnumType)}
                                className="text-gray-200"
                            >
                              {meta.label}
                            </DropdownMenuCheckboxItem>
                        ))}
                      </>
                  )
                },
                {
                  label: "علائم",
                  value: selectedSymptoms.length,
                  onClick: toggleSymptom,
                  content: (
                      <>
                        <DropdownMenuLabel>علائم</DropdownMenuLabel>
                        <DropdownMenuSeparator className="bg-white/10" />
                        {Object.entries(SymptomEnum).map(([key, meta]) => (
                            <DropdownMenuCheckboxItem
                                key={key}
                                checked={selectedSymptoms.includes(key as SymptomKey)}
                                onCheckedChange={() => toggleSymptom(key as SymptomKey)}
                                className="text-gray-200"
                            >
                              {meta.persianValue}
                            </DropdownMenuCheckboxItem>
                        ))}
                      </>
                  )
                }
              ].map(({ label, value, content }, idx) => (
                  <DropdownMenu key={idx}>
                    <DropdownMenuTrigger asChild>
                      <Button
                          variant="outline"
                          className="gap-2 h-12 px-4 bg-white/5 border-white/10 text-gray-200 hover:bg-white/10
                              hover:border-blue-500/40 transition-all rounded-xl backdrop-blur-xl"
                          style={{
                            WebkitBackdropFilter: "blur(12px)",
                            backdropFilter: "blur(12px)",
                          }}
                      >
                        <Filter className="h-4 w-4" />
                        {label}
                        {value > 0 && (
                            <Badge
                                variant="secondary"
                                className="ml-1 px-2 py-0.5 h-5 bg-blue-500/20 text-blue-200 border-blue-500/40"
                            >
                              {value}
                            </Badge>
                        )}
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent
                        className="w-56 bg-black/80 border-white/10 backdrop-blur-xl rounded-xl p-2"
                        align="end"
                        style={{
                          WebkitBackdropFilter: "blur(12px)",
                          backdropFilter: "blur(12px)",
                        }}
                    >
                      {content}
                    </DropdownMenuContent>
                  </DropdownMenu>
              ))}

              {/* Clear All */}
              {(selectedType !== "all" ||
                  selectedSpecies.length > 0 ||
                  selectedDiagnosisMethods.length > 0 ||
                  selectedTreatmentTypes.length > 0 ||
                  selectedSymptoms.length > 0 ||
                  searchTerm) && (
                  <Button
                      variant="ghost"
                      size="sm"
                      onClick={clearAllFilters}
                      className="h-12 px-4 text-gray-300 hover:text-white hover:bg-red-500/20 rounded-xl"
                  >
                    پاک کردن فیلترها
                  </Button>
              )}
            </div>
          </div>

          {/* Disease Table */}
          <div
              className="rounded-2xl overflow-hidden border border-white/10"
              style={{
                ...STYLES.glassPanel,
                boxShadow: "0 20px 40px -15px rgba(0, 0, 0, 0.6)"
              }}
          >
            <Table>
              <TableHeader>
                <TableRow className="border-b border-white/10 bg-black/30 ">
                  <TableHead className="w-[40px] text-gray-300 font-medium text-center">#</TableHead>
                  <TableHead
                      className="cursor-pointer min-w-[220px] text-gray-300 font-medium text-center"
                      onClick={() => handleSort("name")}
                  >
                    نام <ArrowUpDown className="inline w-3.5 h-3.5 ml-1" />
                  </TableHead>
                  <TableHead className="cursor-pointer w-[220px] text-gray-300 font-medium text-center " onClick={() => handleSort("type")}>
                    نوع <ArrowUpDown className="inline w-3.5 h-3.5 ml-1" />
                  </TableHead>
                  <TableHead className="w-[170px] text-gray-300 font-medium text-center ">گونه‌ها</TableHead>
                  <TableHead className="w-[160px] text-gray-300 font-medium text-center">علائم اصلی</TableHead>
                  <TableHead className="w-[40px]"></TableHead>
                </TableRow>
              </TableHeader>

              <TableBody>
                {filteredDiseases.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center py-16 text-gray-500">
                        بیماری مورد نظر یافت نشد.
                      </TableCell>
                    </TableRow>
                ) : (
                    filteredDiseases.map((disease, index) => (
                        <TableRow
                            key={disease.id}
                            className="border-b border-white/5 hover:bg-white/5 transition-colors cursor-pointer"
                            onClick={() => handleViewDisease(disease)}
                        >
                          <TableCell className="font-mono text-sm text-gray-500 w-10">
                            {index + 1}
                          </TableCell>
                          <TableCell>
                            <div className="font-medium text-gray-100 ">
                              {disease.per_name}
                            </div>
                            {disease.per_description && (
                                <div className="text-sm text-gray-400 line-clamp-1 mt-1">
                                  {disease.per_description.replace(".", "")}
                                  {/*{truncateText(disease.per_description.replace(".", ""), 80)}*/}
                                </div>
                            )}
                          </TableCell>
                          <TableCell>
                            <Badge
                                className="text-xs px-3 py-1.5 rounded-full"
                                style={{
                                  background: "rgba(96, 165, 250, 0.2)",
                                  color: "#93c5fd",
                                  border: "1px solid rgba(96, 165, 250, 0.4)",
                                }}
                            >
                              {DiseaseTypeEnum[disease.type]?.label || disease.type}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            {disease.affected_species?.length ? (
                                <div className="flex flex-wrap gap-1.5">
                                  {disease.affected_species.map((species) => {
                                    const isDog = species === "CANINE";
                                    const isCat = species === "FELINE";
                                    return (
                                        <Badge
                                            key={species}
                                            className="text-xs px-2.5 py-1 rounded-full"
                                            style={{
                                              background: isDog
                                                  ? "rgba(59, 130, 246, 0.2)"
                                                  : isCat
                                                      ? "rgba(236, 72, 153, 0.2)"
                                                      : "rgba(168, 85, 247, 0.2)",
                                              color: isDog
                                                  ? "#93c5fd"
                                                  : isCat
                                                      ? "#f472b6"
                                                      : "#c4b5fd",
                                              border: isDog
                                                  ? "1px solid rgba(59, 130, 246, 0.4)"
                                                  : isCat
                                                      ? "1px solid rgba(236, 72, 153, 0.4)"
                                                      : "1px solid rgba(168, 85, 247, 0.4)",
                                            }}
                                        >
                                          {SpeciesEnum[species]?.label || species}
                                        </Badge>
                                    );
                                  })}
                                </div>
                            ) : (
                                <span className="text-gray-500">—</span>
                            )}
                          </TableCell>
                          <TableCell>
                            {disease.mainSymptom ? (
                                <Badge
                                    className="text-xs px-3 py-1.5 rounded-full bg-red-500/20 text-red-200 border-red-500/40"
                                >
                                  {SymptomEnum[disease.mainSymptom]?.persianValue || disease.mainSymptom}
                                </Badge>
                            ) : (
                                <span className="text-gray-500">—</span>
                            )}
                          </TableCell>
                          <TableCell className="text-right pr-3">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild onClick={(e) => e.stopPropagation()}>
                                <Button
                                    variant="ghost"
                                    size="icon"
                                    className="h-9 w-9 rounded-full bg-white/5 hover:bg-white/10 text-gray-300"
                                >
                                  <MoreVertical className="h-4 w-4" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent
                                  align="end"
                                  className="bg-black/80 border-white/10 backdrop-blur-xl rounded-xl"
                                  style={{
                                    WebkitBackdropFilter: "blur(12px)",
                                    backdropFilter: "blur(12px)",
                                  }}
                              >
                                <DropdownMenuItem
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      handleViewDisease(disease);
                                    }}
                                    className="text-gray-200 hover:text-white hover:bg-white/10"
                                >
                                  مشاهده جزئیات
                                </DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>
                    ))
                )}
              </TableBody>
            </Table>
          </div>
        </div>
      </div>
  );
}