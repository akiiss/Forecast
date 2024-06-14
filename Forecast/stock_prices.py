import pandas as pd
import yfinance as yf
from datetime import datetime, timedelta

def fetch_stock_data(stock_symbols, companies_name, start_date, end_date, output_file):
    """
    Функция для загрузки данных о ценах акций из Yahoo Finance и сохранения в файле CSV.

    Args:
    - stock_symbols (list): Список символов акций для загрузки (например, ['AAPL', 'GOOG', 'MSFT']).
    - companies_name (list): Список названий компаний (например, ['APPLE', 'GOOGLE', 'MICROSOFT']).
    - start_date (str): Начальная дата в формате 'YYYY-MM-DD'.
    - end_date (str): Конечная дата в формате 'YYYY-MM-DD'.
    - output_file (str): Имя файла CSV, в который нужно сохранить данные.

    Returns:
    - DataFrame: DataFrame с данными о ценах акций.
    """
    # Создаем пустой DataFrame для хранения данных
    all_data = pd.DataFrame()

    # Загружаем данные для каждого символа акции
    for symbol, company in zip(stock_symbols, companies_name):
        # Загружаем данные из Yahoo Finance
        data = yf.download(symbol, start=start_date, end=end_date)

        # Получаем информацию о рыночной капитализации
        info = yf.Ticker(symbol).info
        market_cap = info.get('marketCap')

        # Добавляем столбец с именем компании, символом и рыночной капитализацией
        data['Company'] = company
        data['Symbol'] = symbol
        data['MarketCap'] = market_cap

        # Вычисляем изменение цены и процентное изменение
        data['Percent Change'] = data['Close'].pct_change() * 100

        # Удаляем строки, где столбец 'Percent Change' пустой
        data.dropna(subset=['Percent Change'], inplace=True)

        # Выбираем нужные столбцы и переименовываем их
        data = data[['Symbol', 'Company', 'Close', 'Open', 'High', 'Low', 'Volume', 'MarketCap', 'Percent Change']]

        # Добавляем данные к общему DataFrame
        all_data = pd.concat([all_data, data])

    # Сбрасываем индекс, чтобы удалить столбец с датой
    all_data.reset_index(drop=True, inplace=True)

    # Сохраняем данные в файл CSV
    all_data.to_csv(output_file, index=False, header=True)

    return all_data

if __name__ == "__main__":
    # Параметры для загрузки данных
    symbols_to_fetch = ['AAPL', 'GOOG', 'MSFT', 'AMZN', 'TSLA', 'NVDA', 'IBM', 'BA', 'NFLX', 'INTC']  # Список символов акций
    companies_name = ["Apple Inc.", "Google", "Microsoft", "Amazon", "Tesla Inc.", "Nvidia", 'IBM', 'Boeing', 'Netflix', 'Intel Inc.']
    end_date = datetime.now().strftime('%Y-%m-%d')  # Текущая дата
    start_date = (datetime.now() - timedelta(days=2)).strftime('%Y-%m-%d')  # Позавчерашний день
    output_file = 'stock_prices.csv'  # Имя файла для сохранения данных

    # Загрузка данных и сохранение в файл CSV
    fetch_stock_data(symbols_to_fetch, companies_name, start_date, end_date, output_file)
