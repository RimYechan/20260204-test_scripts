#!/bin/bash
# 디스크 용량 모니터링 스크립트

# 경고 임계값 설정 (%)
WARNING=70
CRITICAL=85

# 루트 파티션 사용률 확인
USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "=========================================="
echo "디스크 용량 모니터링"
echo "현재 시각: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
echo ""

# 현재 사용률 출력
echo "루트 파티션(/) 사용률: ${USAGE}%"
echo ""

# 조건에 따른 경고 메시지
if [ $USAGE -ge $CRITICAL ]; then
    echo "⚠️  [CRITICAL] 디스크 용량이 위험 수준입니다!"
    echo "즉시 조치가 필요합니다."
elif [ $USAGE -ge $WARNING ]; then
    echo "⚠️  [WARNING] 디스크 용량 주의가 필요합니다."
    echo "불필요한 파일 정리를 권장합니다."
else
    echo "✓ [OK] 디스크 용량 정상"
fi

echo ""
echo "=========================================="

# 용량 많이 차지하는 디렉토리 상위 5개
echo ""
echo "[용량 많이 차지하는 디렉토리 TOP 5]"
du -h --max-depth=1 / 2>/dev/null | sort -rh | head -6 | tail -5
