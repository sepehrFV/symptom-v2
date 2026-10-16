import DiseaseDetailViewContent from "./PageContent";

export async function generateStaticParams() {
  const res = await fetch(
      `${process.env.NEXT_PUBLIC_BASE_URL}/disease`
  );

  const diseases = await res.json();

  return diseases.map((disease: any) => ({
    id: String(disease.id),
  }));
}

export default function Page() {
  return <DiseaseDetailViewContent />;
}