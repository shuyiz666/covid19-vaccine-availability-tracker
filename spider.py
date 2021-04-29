from selenium.webdriver import Chrome, ChromeOptions
import pymssql
import time
from bs4 import BeautifulSoup
import re

def get_conn():
    """
    connect SQL Server

    return: connection, cursor
    """
    # create connection
    conn = pymssql.connect(server='localhost',
                           user='sa',
                           password='Zsystc290021!#',
                           database='Cov_vaccine')
    # create cursor
    cursor = conn.cursor()
    return conn, cursor

def get_data():
    """
    get data from starmarket schedule vaccine poge
    simulate searching with zipcode 02134

    return: page source for vaccine availability around 02134
    """
    starmarket_url = "https://www.mhealthappointments.com/covidappt"
    option = ChromeOptions()  # create chrome browser
    browser = Chrome(options=option, executable_path="/Applications/chromedriver")
    browser.get(starmarket_url)
    browser.find_element_by_id('covid_vaccine_search_input').send_keys('02134')
    browser.find_element_by_xpath('//*[@id="covid_vaccine_search"]/div[1]/div[2]/button').click()
    time.sleep(5)

    starmarket_vaccine = browser.page_source
    return starmarket_vaccine



def streaming(page_source):
    """
    parse page source to store information and availability
    save store information and availability as (key, pair) to dictionary

    page_source: the web page including the vaccine availability information
    return: store_info for nearby store
    """
    soup = BeautifulSoup(page_source, "html.parser")

    store_info = {}
    store_container = soup.find_all('fieldset', class_='radio-group-container')[1]
    for store in store_container.find_all('div', class_='col-sm-12 mt-1 store-list-row'):
        store_name = store.find('label').get_text()
        store_availability = store.find('span').get_text()
        store_info[store_name] = store_availability

    return store_info



def insert_data(cursor, data):
    """
    format and insert information into raw table
    cursor: database cursor
    data: a dictionary as format of (store, availability)
    """
    for store in data.keys():
        store_information = re.split('[,\-]', store)
        store_type = "Star Market" if "Star" in store_information[0].strip().split(" ")[0] else "Shaws"
        address_id = store_information[0].strip().split(" ")[-1]
        address = store_information[1].strip()
        city = store_information[2].strip()
        state = store_information[3].strip()
        zipcode = store_information[4].strip()
        availability = data[store]
        records = "(GETDATE(), '" + store_type + "', '" + address_id + "', '" + address + "', '" + city + "', '" + state + "', '" + zipcode + "', '" + availability + "')"
        print(records)
        query = "INSERT INTO Raw (CreateTime, Store, AddressId, Address, City, State, ZipCode, Availability) VALUES " + records

        cursor.execute(query)
        conn.commit()

def update_BI():
    sql = "TRUNCATE TABLE BI " \
          "INSERT INTO BI " \
          "SELECT his.CreateTime, sb.StoreBrandName, st.StateName, ct.CityName, stu.StatusName " \
          "FROM History his " \
          "INNER JOIN Store sto ON sto.StoreId = his.StoreId " \
          "INNER JOIN StoreBrand sb ON sb.StoreBrandId = sto.StoreBrandId " \
          "INNER JOIN ZipCode zp ON zp.ZipCodeId = sto.ZipCodeId " \
          "INNER JOIN State st ON st.StateId = zp.StateId " \
          "INNER JOIN City ct ON ct.CityId = zp.CityId " \
          "INNER JOIN Status stu ON stu.StatusId = his.StatusId"
    cursor.execute(sql)
    conn.commit()

def close_conn(conn, cursor):
    if cursor:
        cursor.close()
    if conn:
        conn.close()



if __name__ == "__main__":
    conn, cursor = get_conn()
    page_source = get_data()
    nearby_store = streaming(page_source)
    insert_data(cursor, nearby_store)
    update_BI()
    close_conn(conn, cursor)





