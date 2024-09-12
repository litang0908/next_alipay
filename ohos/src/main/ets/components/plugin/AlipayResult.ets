export interface AlipayResult {
  resultStatus: string;
  memo: string | null;
  result: Record<string, string | undefined> | string | null;
}