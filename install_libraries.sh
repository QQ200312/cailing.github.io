pip install pandas fuzzywuzzy openpyxl
import pandas as pd
from typing import Dict, List

class DataLoader:
    def __init__(self):
        self.bank_data = None
        self.account_data = None

    def load_bank_statement(self, file_path: str) -> pd.DataFrame:
        """导入银行流水数据"""
        try:
            if file_path.endswith('.xlsx'):
                df = pd.read_excel(file_path)
            elif file_path.endswith('.csv'):
                df = pd.read_csv(file_path)
            else:
                raise ValueError("不支持的文件格式")
            # 标准化列名
            df.columns = self._standardize_columns(df.columns)
            # 数据清洗
            df = self._clean_data(df)
            self.bank_data = df
            return df
        except Exception as e:
            print(f"导入银行流水失败: {str(e)}")
            return None

    def _standardize_columns(self, columns: List) -> List:
        """统一列名格式"""
        column_map = {
            '交易日期': 'date',
            '金额': 'amount',
            '借方': 'debit',
            '贷方': 'credit',
            '摘要': 'description',
            '余额': 'balance'
        }
        return [column_map.get(col, col) for col in columns]

    def _clean_data(self, df: pd.DataFrame) -> pd.DataFrame:
        """清洗数据"""
        # 处理日期格式
        df['date'] = pd.to_datetime(df['date'])
        # 统一金额格式
        for col in ('amount', 'debit', 'credit', 'balance'):
            if col in df.columns:
                df[col] = df[col].replace('(\$,)', '', regex=True).astype(float)
        return df

    def load_account_data(self, file_path: str) -> pd.DataFrame:
        """导入账务数据"""
        try:
            if file_path.endswith('.xlsx'):
                df = pd.read_excel(file_path)
            elif file_path.endswith('.csv'):
                df = pd.read_csv(file_path)
            else:
                raise ValueError("不支持的文件格式")
            df.columns = self._standardize_columns(df.columns)
            df = self._clean_data(df)
            self.account_data = df
            return df
        excep
