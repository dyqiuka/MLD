import React from 'react';
import { MedicalService, Doctor, Branch } from '../../../../backend/src/data/database';
import {
  ArrowLeftIcon,
  HeartIcon,
  ShareIcon,
  ClockIcon,
  StarIcon,
  CheckIcon,
  CloseIcon,
  PhoneIcon,
  LocationIcon,
  MapIcon,
} from '@/components/Icons';

export const BranchDirectoryModal: React.FC<{
  branches: Branch[];
  onClose: () => void;
  onSelectBranch: (branch: Branch) => void;
}> = ({ branches, onClose, onSelectBranch }) => (
  <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden text-[#40352F]">
    <div className="px-4 pt-4 pb-3">
      <button onClick={onClose} className="w-9 h-9 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-center mb-4"><ArrowLeftIcon size={18} /></button>
      <h1 className="text-[21px] font-bold text-[#6F452C]">Hệ thống chi nhánh</h1>
      <p className="text-[11px] text-[#7A685D] mt-1">Tìm cơ sở phù hợp với bạn.</p>
    </div>
    <div className="flex-1 overflow-y-auto px-4 pb-24 space-y-3">
      <div className="flex gap-2"><span className="w-10 h-10 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-center"><LocationIcon size={17} color="#A65317" /></span><div className="h-10 flex-1 rounded-[8px] bg-white border border-[#DED2C5] px-3 flex items-center text-[10px] text-[#8A7D74]">Tìm chi nhánh, địa chỉ...</div></div>
      <label className="block text-[10px] text-[#6F625B]">Tỉnh / thành phố<span className="h-10 mt-1 px-3 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-between text-[#40352F]">Tất cả tỉnh / thành phố <span>⌄</span></span></label>
      <div className="flex gap-2"><button className="flex-1 h-10 rounded-[8px] bg-white border border-[#A65317] text-[#A65317] text-[10px] font-bold">Gần tôi</button><button className="px-4 h-10 rounded-[8px] bg-[#A65317] text-white text-[10px]">Danh sách</button><button className="px-4 h-10 rounded-[8px] bg-white border border-[#DED2C5] text-[10px]">Bản đồ</button></div>
      <label className="block text-[10px] text-[#6F625B]">Dịch vụ tại cơ sở<span className="h-10 mt-1 px-3 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-between text-[#40352F]">Tất cả dịch vụ <span>⌄</span></span></label>
      <div className="p-3 rounded-[8px] bg-[#F3E2CE] text-[9px]">Dữ liệu minh họa · {branches.length} cơ sở hữu cấu. Không sử dụng vị trí hoặc khoảng cách thực tế.</div>
      {branches.map((branch) => <button key={branch.id} onClick={() => onSelectBranch(branch)} className="w-full text-left rounded-[10px] overflow-hidden bg-white border border-[#DED2C5]"><img src="https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=800&auto=format&fit=crop&q=80" alt={branch.name} className="w-full h-[180px] object-cover" /><div className="p-3"><h3 className="text-[12px] font-bold">{branch.name}</h3><p className="text-[10px] text-[#7A685D] mt-1">{branch.address}</p></div></button>)}
    </div>
  </div>
);

export const SpecialistDirectoryModal: React.FC<{
  doctors: Doctor[];
  onClose: () => void;
  onSelectDoctor: (doctor: Doctor) => void;
}> = ({ doctors, onClose, onSelectDoctor }) => (
  <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden text-[#40352F]">
    <div className="px-4 pt-4 pb-3"><button onClick={onClose} className="w-9 h-9 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-center mb-4"><ArrowLeftIcon size={18} /></button><h1 className="text-[21px] font-bold text-[#6F452C]">Đội ngũ chuyên viên</h1><p className="text-[11px] text-[#7A685D] mt-1">Đồng hành cùng bạn trong hành trình chăm sóc sức khỏe.</p></div>
    <div className="flex-1 overflow-y-auto px-4 pb-24 space-y-3">
      <div className="flex gap-2"><span className="w-10 h-10 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-center"><LocationIcon size={17} color="#A65317" /></span><div className="h-10 flex-1 rounded-[8px] bg-white border border-[#DED2C5] px-3 flex items-center text-[10px] text-[#8A7D74]">Tìm tên hoặc chuyên môn...</div></div>
      <div className="grid grid-cols-2 gap-2">{['Chi nhánh', 'Chuyên môn', 'Dịch vụ', 'Giờ minh họa'].map((label) => <label key={label} className="text-[9px] text-[#6F625B]">{label}<span className="h-10 mt-1 px-3 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-between text-[10px] text-[#40352F]">Tất cả <span>⌄</span></span></label>)}</div>
      <label className="block text-[9px] text-[#6F625B]">Sắp xếp<span className="h-10 mt-1 px-3 rounded-[8px] bg-white border border-[#DED2C5] flex items-center justify-between text-[10px] text-[#40352F]">Theo tên chuyên viên <span>⌄</span></span></label>
      <div className="p-3 rounded-[8px] bg-[#F3E2CE] text-[9px]">{doctors.length} hồ sơ minh họa · Không phải nhân sự hoặc lịch trống thực tế.</div>
      {doctors.map((doctor) => <button key={doctor.id} onClick={() => onSelectDoctor(doctor)} className="w-full p-3 rounded-[10px] bg-white border border-[#DED2C5] flex gap-3 text-left"><img src={doctor.avatar} alt={doctor.name} className="w-20 h-20 rounded-[8px] object-cover" /><div><h3 className="text-[12px] font-bold">{doctor.name}</h3><p className="text-[10px] text-[#7A685D] mt-1">{doctor.title}</p><span className="text-[9px] text-[#A65317] mt-2 block">Hồ sơ minh họa</span></div></button>)}
    </div>
  </div>
);

// 1. SERVICE DETAIL MODAL (Matching Figma B03 - Dịch vụ đầy đủ)
export const ServiceDetailModal: React.FC<{
  service: MedicalService | null;
  onClose: () => void;
  onBookNow: (service: MedicalService) => void;
}> = ({ service, onClose, onBookNow }) => {
  if (!service) return null;

  return (
    <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
        {/* Header Bar */}
        <div className="relative h-60 w-full overflow-hidden">
          <img src={service.image} alt={service.title} className="w-full h-full object-cover" />
          <button
            onClick={onClose}
            className="absolute top-4 left-4 w-9 h-9 rounded-full bg-white/80 backdrop-blur flex items-center justify-center text-stone-700 shadow"
          >
            <ArrowLeftIcon size={16} color="#40352F" />
          </button>
          <div className="absolute top-4 right-4 flex space-x-2">
            <button className="w-9 h-9 rounded-full bg-white/80 backdrop-blur flex items-center justify-center text-stone-700 shadow">
              <HeartIcon size={16} color="#98501B" />
            </button>
            <button className="w-9 h-9 rounded-full bg-white/80 backdrop-blur flex items-center justify-center text-stone-700 shadow">
              <ShareIcon size={16} color="#40352F" />
            </button>
          </div>
          <div className="absolute bottom-3 left-4 bg-black/60 backdrop-blur-sm px-3 py-1 rounded-full text-white text-[11px] font-semibold flex items-center space-x-1.5">
            <ClockIcon size={12} color="#FFFFFF" />
            <span>{service.durationMinutes} phút • {service.category}</span>
          </div>
        </div>

        {/* Scrollable Body */}
        <div className="p-5 flex-1 overflow-y-auto space-y-5 text-stone-800 text-xs">
          <div>
            <div className="flex justify-between items-start">
              <div>
                <span className="text-[10px] font-bold text-[#98501B] uppercase tracking-wider">
                  {service.category}
                </span>
                <h2 className="text-xl font-bold text-stone-900 mt-0.5">{service.title}</h2>
              </div>
              <div className="text-right">
                <div className="text-base font-bold text-[#98501B]">{service.price.toLocaleString('vi-VN')} ₫</div>
                {service.originalPrice && (
                  <div className="text-[10px] text-stone-400 line-through">
                    {service.originalPrice.toLocaleString('vi-VN')} ₫
                  </div>
                )}
              </div>
            </div>
            <div className="flex items-center space-x-1.5 mt-2">
              <StarIcon size={12} color="#F59E0B" filled />
              <span className="text-stone-800 font-bold">{service.rating}</span>
              <span className="text-stone-400">({service.reviewsCount} đánh giá từ khách hàng)</span>
            </div>
          </div>

          {/* Giới thiệu dịch vụ */}
          <div>
            <h3 className="font-bold text-sm text-stone-900 mb-1.5">Giới thiệu dịch vụ</h3>
            <p className="text-stone-600 leading-relaxed text-xs">{service.description}</p>
          </div>

          {/* Trải nghiệm nổi bật */}
          <div className="p-3.5 bg-white rounded-2xl border border-stone-200 space-y-2">
            <h4 className="font-bold text-stone-800 text-xs">Trải nghiệm nổi bật</h4>
            <div className="space-y-1.5 text-stone-600 text-[11px]">
              <div className="flex items-center space-x-2">
                <CheckIcon size={13} color="#2E8B57" />
                <span>Thư giãn sâu cơ bắp và giảm căng cơ toàn thân</span>
              </div>
              <div className="flex items-center space-x-2">
                <CheckIcon size={13} color="#2E8B57" />
                <span>Kích thích tuần hoàn máu và vi tuần hoàn bạch huyết</span>
              </div>
              <div className="flex items-center space-x-2">
                <CheckIcon size={13} color="#2E8B57" />
                <span>Không gian trị liệu chuẩn spa tĩnh lặng, hương thơm tinh dầu</span>
              </div>
            </div>
          </div>

          {/* Quy trình trải nghiệm 4 bước */}
          <div>
            <h3 className="font-bold text-sm text-stone-900 mb-2.5">Quy trình trải nghiệm</h3>
            <div className="space-y-2 text-[11px]">
              <div className="flex space-x-3 p-2.5 bg-white rounded-xl border border-stone-200">
                <span className="w-5 h-5 rounded-full bg-[#98501B] text-white flex items-center justify-center font-bold text-[10px] flex-shrink-0">
                  1
                </span>
                <div>
                  <div className="font-bold text-stone-800">Tư vấn nhu cầu</div>
                  <div className="text-stone-500 mt-0.5">Thưởng trà thảo mộc và xác định vùng cơ căng mỏi</div>
                </div>
              </div>

              <div className="flex space-x-3 p-2.5 bg-white rounded-xl border border-stone-200">
                <span className="w-5 h-5 rounded-full bg-[#98501B] text-white flex items-center justify-center font-bold text-[10px] flex-shrink-0">
                  2
                </span>
                <div>
                  <div className="font-bold text-stone-800">Chuẩn bị dịch vụ</div>
                  <div className="text-stone-500 mt-0.5">Thay trang phục và thả lỏng trong phòng trị liệu riêng</div>
                </div>
              </div>

              <div className="flex space-x-3 p-2.5 bg-white rounded-xl border border-stone-200">
                <span className="w-5 h-5 rounded-full bg-[#98501B] text-white flex items-center justify-center font-bold text-[10px] flex-shrink-0">
                  3
                </span>
                <div>
                  <div className="font-bold text-stone-800">Tiến hành chăm sóc ({service.durationMinutes} phút)</div>
                  <div className="text-stone-500 mt-0.5">Kỹ thuật viên thao tác chuẩn quy trình MLD y khoa</div>
                </div>
              </div>

              <div className="flex space-x-3 p-2.5 bg-white rounded-xl border border-stone-200">
                <span className="w-5 h-5 rounded-full bg-[#98501B] text-white flex items-center justify-center font-bold text-[10px] flex-shrink-0">
                  4
                </span>
                <div>
                  <div className="font-bold text-stone-800">Hướng dẫn sau dịch vụ</div>
                  <div className="text-stone-500 mt-0.5">Lời khuyên chăm sóc tại nhà và uống nước ấm bổ sung</div>
                </div>
              </div>
            </div>
          </div>

          {/* Lưu ý chuẩn bị */}
          <div className="p-3 bg-amber-50 rounded-2xl border border-amber-200 text-stone-600 text-[11px] space-y-1">
            <div className="font-bold text-[#98501B]">Thông tin cần biết:</div>
            {service.preparationNotes.map((note, idx) => (
              <div key={idx} className="flex items-start space-x-1.5">
                <span>•</span>
                <span>{note}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Fixed Bottom Bar */}
        <div className="p-4 bg-white border-t border-stone-200 flex justify-between items-center shadow-lg">
          <div>
            <div className="text-base font-bold text-[#98501B]">{service.price.toLocaleString('vi-VN')} ₫</div>
            <div className="text-[10px] text-stone-500">{service.durationMinutes} phút trị liệu</div>
          </div>
          <button
            onClick={() => onBookNow(service)}
            className="px-6 py-3 bg-[#98501B] text-white font-bold rounded-xl shadow-md hover:bg-[#884218] transition text-xs"
          >
            Đặt lịch ngay
          </button>
        </div>
      </div>
  );
};

// 2. SPECIALIST DETAIL MODAL (Matching Figma B06 - Chuyên viên đầy đủ)
export const SpecialistDetailModal: React.FC<{
  doctor: Doctor | null;
  onClose: () => void;
  onBookWithDoctor: (doctor: Doctor) => void;
}> = ({ doctor, onClose, onBookWithDoctor }) => {
  if (!doctor) return null;

  return (
    <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
        {/* Top Cover */}
        <div className="relative h-48 bg-stone-300">
          <img src={doctor.avatar} alt={doctor.name} className="w-full h-full object-cover" />
          <button
            onClick={onClose}
            className="absolute top-4 left-4 w-9 h-9 rounded-full bg-white/80 backdrop-blur flex items-center justify-center text-stone-700 shadow"
          >
            <ArrowLeftIcon size={16} color="#40352F" />
          </button>
        </div>

        {/* Scrollable Body */}
        <div className="p-5 flex-1 overflow-y-auto space-y-4 text-xs text-stone-800">
          <div className="flex justify-between items-start">
            <div>
              <h2 className="text-xl font-bold text-stone-900">{doctor.name}</h2>
              <div className="text-[#98501B] font-semibold mt-0.5">{doctor.title}</div>
              <div className="text-stone-500 text-[11px] mt-0.5">{doctor.hospital}</div>
            </div>
            <div className="p-2 bg-amber-50 rounded-xl border border-amber-200 text-center">
              <div className="font-bold text-amber-700 text-sm flex items-center justify-center space-x-1">
                <StarIcon size={12} color="#F59E0B" filled />
                <span>{doctor.rating}</span>
              </div>
              <div className="text-[9px] text-stone-500">{doctor.reviewsCount} đánh giá</div>
            </div>
          </div>

          <div>
            <h3 className="font-bold text-sm text-stone-900 mb-1">Giới thiệu</h3>
            <p className="text-stone-600 leading-relaxed">{doctor.bio}</p>
          </div>

          <div className="grid grid-cols-2 gap-3 p-3 bg-white rounded-2xl border border-stone-200">
            <div>
              <div className="text-[10px] text-stone-400">Chuyên môn chính</div>
              <div className="font-bold text-stone-800 mt-0.5">{doctor.specialty}</div>
            </div>
            <div>
              <div className="text-[10px] text-stone-400">Kinh nghiệm</div>
              <div className="font-bold text-stone-800 mt-0.5">{doctor.experienceYears} năm thực hành</div>
            </div>
          </div>

          {/* Lịch làm việc */}
          <div className="space-y-2">
            <h3 className="font-bold text-sm text-stone-900">Lịch làm việc tuần này</h3>
            <div className="grid grid-cols-3 gap-2 text-center text-[11px]">
              <div className="p-2.5 bg-white rounded-xl border border-stone-200">
                <div className="font-bold text-stone-800">Thứ Hai - Thứ Sáu</div>
                <div className="text-[#98501B] font-semibold mt-1">09:00 - 18:00</div>
              </div>
              <div className="p-2.5 bg-white rounded-xl border border-stone-200">
                <div className="font-bold text-stone-800">Thứ Bảy</div>
                <div className="text-[#98501B] font-semibold mt-1">09:00 - 19:00</div>
              </div>
              <div className="p-2.5 bg-white rounded-xl border border-stone-200">
                <div className="font-bold text-stone-800">Chủ Nhật</div>
                <div className="text-[#98501B] font-semibold mt-1">09:00 - 16:00</div>
              </div>
            </div>
          </div>

          {/* Đánh giá từ khách hàng */}
          <div className="space-y-2 pt-2 border-t border-stone-200">
            <h3 className="font-bold text-sm text-stone-900">Đánh giá từ khách hàng</h3>
            <div className="p-3 bg-white rounded-xl border border-stone-200 space-y-1">
              <div className="flex justify-between items-center text-[11px]">
                <span className="font-bold text-stone-800">Nguyễn Minh Anh</span>
                <span className="text-amber-600 font-bold flex items-center space-x-1">
                  <StarIcon size={10} color="#F59E0B" filled />
                  <span>5.0</span>
                </span>
              </div>
              <p className="text-[11px] text-stone-600 italic">
                "Kỹ thuật viên thao tác rất chu đáo, giải tỏa hoàn toàn cơn đau mỏi vai gáy. Rất hài lòng!"
              </p>
            </div>
          </div>
        </div>

        {/* Fixed Bottom */}
        <div className="p-4 bg-white border-t border-stone-200 shadow-lg">
          <button
            onClick={() => onBookWithDoctor(doctor)}
            className="w-full py-3 bg-[#98501B] text-white font-bold rounded-xl shadow-md hover:bg-[#884218] transition text-xs"
          >
            Đặt lịch với chuyên viên {doctor.name}
          </button>
        </div>
      </div>
  );
};

// 3. BRANCH DETAIL MODAL (Matching Figma B04 - Chi nhánh đầy đủ)
export const BranchDetailModal: React.FC<{
  branch: Branch | null;
  onClose: () => void;
  onSelectBranch: (branch: Branch) => void;
  onOpenDirections?: (branch: Branch) => void;
}> = ({ branch, onClose, onSelectBranch, onOpenDirections }) => {
  if (!branch) return null;

  return (
    <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
        <div className="p-4 border-b border-[#EADECF] flex justify-between items-center bg-white">
          <h2 className="font-bold text-base text-[#40352F]">Thông tin cơ sở</h2>
          <button onClick={onClose} className="w-8 h-8 rounded-full bg-stone-100 flex items-center justify-center text-stone-500 hover:bg-stone-200 transition">
            <CloseIcon size={14} color="#40352F" />
          </button>
        </div>

        <div className="p-5 flex-1 overflow-y-auto space-y-4 text-xs text-stone-800">
          <div className="h-44 w-full rounded-2xl overflow-hidden shadow-sm border border-[#EADECF]">
            <img
              src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=600&auto=format&fit=crop&q=80"
              alt={branch.name}
              className="w-full h-full object-cover"
            />
          </div>

          <div>
            <h3 className="text-lg font-bold text-[#40352F]">{branch.name}</h3>
            <p className="text-stone-600 mt-1 flex items-start space-x-1.5">
              <LocationIcon size={14} color="#98501B" className="shrink-0 mt-0.5" />
              <span>{branch.address}</span>
            </p>
            <div className="text-[#98501B] font-semibold mt-1 flex items-center space-x-1.5">
              <PhoneIcon size={12} color="#98501B" />
              <span>Hotline: {branch.phone}</span>
            </div>
          </div>

          <div className="p-3.5 bg-white rounded-2xl border border-[#EADECF] space-y-2">
            <h4 className="font-bold text-[#40352F]">Tiện nghi không gian</h4>
            <div className="grid grid-cols-2 gap-2 text-[11px] text-stone-600">
              <div className="flex items-center space-x-1.5">
                <CheckIcon size={12} color="#2E8B57" />
                <span>Phòng VIP riêng tư</span>
              </div>
              <div className="flex items-center space-x-1.5">
                <CheckIcon size={12} color="#2E8B57" />
                <span>Trà thảo mộc chào mừng</span>
              </div>
              <div className="flex items-center space-x-1.5">
                <CheckIcon size={12} color="#2E8B57" />
                <span>Chỗ đỗ xe ô tô thuận tiện</span>
              </div>
              <div className="flex items-center space-x-1.5">
                <CheckIcon size={12} color="#2E8B57" />
                <span>Không gian yên tĩnh thư thái</span>
              </div>
            </div>
          </div>

          <div className="p-3 bg-[#FBF1E8] rounded-2xl text-[11px] text-stone-700 space-y-1 border border-[#EADECF]">
            <div className="font-bold text-[#40352F]">Giờ hoạt động:</div>
            <div className="flex justify-between">
              <span>Thứ Hai - Chủ Nhật:</span>
              <span className="font-bold text-[#98501B]">09:00 - 20:00</span>
            </div>
          </div>
        </div>

        <div className="p-4 bg-white border-t border-[#EADECF] flex space-x-3 shadow-lg">
          <button
            onClick={() => onOpenDirections ? onOpenDirections(branch) : null}
            className="flex-1 py-3 bg-[#FAF6F0] hover:bg-[#F3E2CE] text-[#98501B] font-bold rounded-xl border border-[#EADECF] text-xs transition flex items-center justify-center space-x-1.5"
          >
            <MapIcon size={14} color="#98501B" />
            <span>Chỉ đường</span>
          </button>
          <button
            onClick={() => onSelectBranch(branch)}
            className="flex-1 py-3 bg-[#98501B] text-white font-bold rounded-xl shadow-md text-xs hover:bg-[#804215] active:scale-95 transition"
          >
            Đặt lịch tại cơ sở này
          </button>
        </div>
      </div>
  );
};

// 4. LOCATION DIRECTIONS MODAL (Matching Figma B — Vị trí - Quyền truy cập & Hướng dẫn)
export const LocationDirectionsModal: React.FC<{
  branch: Branch | null;
  onClose: () => void;
  onBookAtBranch?: (branch: Branch) => void;
}> = ({ branch, onClose, onBookAtBranch }) => {
  const [copied, setCopied] = React.useState(false);

  if (!branch) return null;

  const handleCopy = () => {
    navigator.clipboard?.writeText(branch.address);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
        {/* Header */}
        <div className="p-4 border-b border-[#EADECF] flex justify-between items-center bg-white">
          <div className="flex items-center space-x-2">
            <MapIcon size={16} color="#98501B" />
            <h2 className="font-bold text-sm text-[#40352F]">Chỉ đường đến cơ sở</h2>
          </div>
          <button onClick={onClose} className="w-8 h-8 rounded-full bg-stone-100 flex items-center justify-center text-stone-500 hover:bg-stone-200 transition">
            <CloseIcon size={14} color="#40352F" />
          </button>
        </div>

        {/* Content */}
        <div className="p-5 flex-1 overflow-y-auto space-y-4 text-xs text-stone-800">
          {/* Branch summary */}
          <div className="bg-white p-4 rounded-2xl border border-[#EADECF] shadow-sm space-y-1.5">
            <h3 className="font-bold text-sm text-[#40352F]">{branch.name}</h3>
            <p className="text-stone-600 text-xs flex items-start space-x-1.5">
              <LocationIcon size={14} color="#98501B" className="shrink-0 mt-0.5" />
              <span>{branch.address}</span>
            </p>
            <div className="text-[11px] text-stone-500 pt-1 border-t border-stone-100 flex justify-between items-center">
              <span>Hotline: {branch.phone}</span>
              <button
                onClick={handleCopy}
                className="text-[#98501B] font-bold hover:underline"
              >
                {copied ? 'Đã sao chép địa chỉ' : 'Sao chép địa chỉ'}
              </button>
            </div>
          </div>

          {/* Map Route Illustration */}
          <div className="relative rounded-2xl overflow-hidden border border-[#EADECF] bg-stone-100 shadow-inner h-48 flex flex-col items-center justify-center text-center p-4">
            <div className="absolute inset-0 bg-gradient-to-b from-[#F3E2CE]/40 to-[#EADECF]/60" />
            <div className="relative z-10 flex flex-col items-center space-y-2">
              <div className="w-12 h-12 rounded-full bg-[#98501B] text-white flex items-center justify-center shadow-md">
                <LocationIcon size={24} color="#FFFFFF" />
              </div>
              <span className="font-bold text-xs text-[#40352F]">Khoảng cách ước tính: ~3.2 km</span>
              <span className="text-[11px] text-stone-500">Thời gian di chuyển ước tính: 8 - 12 phút</span>
            </div>
          </div>

          {/* Step-by-step route directions */}
          <div className="bg-white p-4 rounded-2xl border border-[#EADECF] space-y-2.5">
            <h4 className="font-bold text-xs text-[#40352F] uppercase tracking-wider">Lộ trình gợi ý:</h4>
            <div className="space-y-2 text-[11px] text-stone-600">
              <div className="flex items-start space-x-2">
                <span className="w-4 h-4 rounded-full bg-[#FAF6F0] text-[#98501B] font-bold flex items-center justify-center text-[10px] shrink-0 border border-[#EADECF]">1</span>
                <span>Từ vị trí của bạn, di chuyển theo trục đường chính hướng về trung tâm.</span>
              </div>
              <div className="flex items-start space-x-2">
                <span className="w-4 h-4 rounded-full bg-[#FAF6F0] text-[#98501B] font-bold flex items-center justify-center text-[10px] shrink-0 border border-[#EADECF]">2</span>
                <span>Rẽ vào tuyến đường {branch.address.split(',')[0]} (cách ngã tư 150m).</span>
              </div>
              <div className="flex items-start space-x-2">
                <span className="w-4 h-4 rounded-full bg-[#FAF6F0] text-[#98501B] font-bold flex items-center justify-center text-[10px] shrink-0 border border-[#EADECF]">3</span>
                <span>Cơ sở MLD nằm bên tay phải, có biển hiệu màu nâu đất và bảo vệ hướng dẫn bãi đỗ xe ô tô miễn phí.</span>
              </div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="p-4 bg-white border-t border-[#EADECF] flex space-x-3 shadow-lg">
          <button
            onClick={onClose}
            className="flex-1 py-3 bg-[#FAF6F0] text-stone-700 font-bold rounded-xl border border-[#EADECF] text-xs hover:bg-[#F3E2CE] transition"
          >
            Đóng
          </button>
          {onBookAtBranch && (
            <button
              onClick={() => {
                onClose();
                onBookAtBranch(branch);
              }}
              className="flex-1 py-3 bg-[#98501B] text-white font-bold rounded-xl shadow-md text-xs hover:bg-[#804215] active:scale-95 transition"
            >
              Đặt lịch tại cơ sở này
            </button>
          )}
        </div>
      </div>
  );
};

