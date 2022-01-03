#ifndef ECGWAVEFORMSAMPLES_H
#define ECGWAVEFORMSAMPLES_H

#include <cstdint>

/** Contains recorded ecg waveform samples for simulator. Samples data are filtered.
 *  For frequencies, see ECG::SAMPLE_FREQUENCY */
namespace EcgSamples
{
/** The heart rate of the recorded sinus signal*/
constexpr double sinus_recordingHr = 72.0;

/** ecg dummy data sinus rhythm lead I */
extern const int16_t sinus_lead1[];

/** ecg dummy data sinus rhythm lead II */
extern const int16_t sinus_lead2[];

/** ecg dummy data sinus rhythm lead V1 */
extern const int16_t sinus_leadV1[];

/** ecg dummy data sinus rhythm lead V2 */
extern const int16_t sinus_leadV2[];

/** ecg dummy data sinus rhythm lead V4 */
extern const int16_t sinus_leadV3[];

/** ecg dummy data sinus rhythm lead V4 */
extern const int16_t sinus_leadV4[];

/** ecg dummy data sinus rhythm lead V5 */
extern const int16_t sinus_leadV5[];

/** ecg dummy data sinus rhythm lead V6 */
extern const int16_t sinus_leadV6[];

/** dummy ecg data vfvt rhythm for lead I */
extern const int16_t vfvt_lead1[];

/** dummy ecg data vfvt rhythm for lead II */
extern const int16_t vfvt_lead2[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead I */
extern const int16_t stemi_lead1[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead II */
extern const int16_t stemi_lead2[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V1 */
extern const int16_t stemi_leadV1[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V2 */
extern const int16_t stemi_leadV2[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V3 */
extern const int16_t stemi_leadV3[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V4 */
extern const int16_t stemi_leadV4[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V5 */
extern const int16_t stemi_leadV5[];

/** dummy ecg data, STEMI (2nd I, LAT ST) rhythm lead V6 */
extern const int16_t stemi_leadV6[];

/** dummy ecg data, TAA (AFIB) rhythm lead I */
extern const int16_t taa_lead1[];

/** dummy ecg data, TAA (AFIB) rhythm lead II */
extern const int16_t taa_lead2[];

/** dummy ecg data, TAA (AFIB) rhythm lead V1 */
extern const int16_t taa_leadV1[];

/** dummy ecg data, TAA (AFIB) rhythm lead V2 */
extern const int16_t taa_leadV2[];

/** dummy ecg data, TAA (AFIB) rhythm lead V3 */
extern const int16_t taa_leadV3[];

/** dummy ecg data, TAA (AFIB) rhythm lead V4 */
extern const int16_t taa_leadV4[];

/** dummy ecg data, TAA (AFIB) rhythm lead V5 */
extern const int16_t taa_leadV5[];

/** dummy ecg data, TAA (AFIB) rhythm lead V6 */
extern const int16_t taa_leadV6[];

/** sinus sample size */
extern const int sinus_size;

/** VF/VT sample size */
extern const int vfvt_size;

/** TAA sample size */
extern const int taa_size;

/** STEMI sample size */
extern const int stemi_size;

} // namespace EcgSamples

#endif // ECGWAVEFORMSAMPLES_H
