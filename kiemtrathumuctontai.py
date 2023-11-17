import os
import sys

def kiem_tra_thu_muc_ton_tai(duong_dan_thu_muc):
    return os.path.exists(duong_dan_thu_muc) and os.path.isdir(duong_dan_thu_muc)

# Kiểm tra đối số từ dòng lệnh
if len(sys.argv) == 3:
    duong_dan_thu_muc = sys.argv[1]
    duong_dan_ghi_tep = sys.argv[2]

    if kiem_tra_thu_muc_ton_tai(duong_dan_thu_muc):
        # Xuất tên thư mục vào tệp
        with open(duong_dan_ghi_tep, 'w') as file_ghi:
            file_ghi.write(f"{duong_dan_thu_muc}")
        print(f"Thư mục {duong_dan_thu_muc} tồn tại.")
    else:
        print(f"Thư mục {duong_dan_thu_muc} không tồn tại hoặc không phải là một thư mục.")
else:
    print("Vui lòng nhập đúng số lượng đối số: <đường dẫn thư mục> <đường dẫn ghi tệp>")