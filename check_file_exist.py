import os
import sys

def kiem_tra_tep_ton_tai(duong_dan_thu_muc, ten_tep_kiem_tra):
    duong_dan_tep = os.path.join(duong_dan_thu_muc, ten_tep_kiem_tra)
    return os.path.exists(duong_dan_tep)

# Kiểm tra đối số từ dòng lệnh
if len(sys.argv) == 4:
    ten_tep_kiem_tra = sys.argv[1]
    duong_dan_thu_muc = sys.argv[2]
    duong_dan_ghi_tep = sys.argv[3]

    ket_qua_kiem_tra = kiem_tra_tep_ton_tai(duong_dan_thu_muc, ten_tep_kiem_tra)

    # Ghi tên tệp vào tệp
    with open(duong_dan_ghi_tep, 'a') as file_ghi:
        file_ghi.write(ten_tep_kiem_tra + '\n')

    print(f"Kết quả kiểm tra đã được ghi vào {duong_dan_ghi_tep}.")
else:
    print("Vui lòng nhập đúng số lượng đối số: <tên tệp cần kiểm tra> <thư mục> <đường dẫn ghi tệp>")
