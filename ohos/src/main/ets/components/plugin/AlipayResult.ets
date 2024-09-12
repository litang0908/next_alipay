export interface AlipayResult {
  resultStatus: string;
  memo: string;
  result: Record<string, string | undefined>;
}